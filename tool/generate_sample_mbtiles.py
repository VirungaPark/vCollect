"""Generate the synthetic sample basemap used by the Map screen.

The tiles show no real place: a plain ground, scattered green patches and a
light grid, in mood board colors, around 0°N 0°E (a spot that is clearly
not field data). Real map packages come from Virunga's GIS team later.

Uses only the Python standard library. Output is deterministic, so
rerunning it does not change the committed file.

Usage (from the repository root):
    python tool/generate_sample_mbtiles.py
"""

from __future__ import annotations

import math
import pathlib
import sqlite3
import struct
import zlib

OUTPUT = pathlib.Path(__file__).resolve().parent.parent / "app/assets/map/sample.mbtiles"

# Roughly 2 km square around 0°N 0°E.
WEST, SOUTH, EAST, NORTH = -0.009, -0.009, 0.009, 0.009
MIN_ZOOM, MAX_ZOOM = 12, 18
TILE_SIZE = 256

# Palette index -> RGB. Page ground, green tint patches, line grey grid.
PALETTE = [(0xF3, 0xF4, 0xF0), (0xDF, 0xF1, 0xE4), (0xDB, 0xDC, 0xD7)]
GROUND, PATCH, GRID = 0, 1, 2

PATCH_CELL_DEG = 0.0015  # about 165 m
GRID_STEP_DEG = 0.001  # about 110 m


def lon_to_x(lon: float, zoom: int) -> float:
    return (lon + 180.0) / 360.0 * (1 << zoom)


def lat_to_y(lat: float, zoom: int) -> float:
    rad = math.radians(lat)
    return (1.0 - math.asinh(math.tan(rad)) / math.pi) / 2.0 * (1 << zoom)


def x_to_lon(x: float, zoom: int) -> float:
    return x / (1 << zoom) * 360.0 - 180.0


def y_to_lat(y: float, zoom: int) -> float:
    n = math.pi - 2.0 * math.pi * y / (1 << zoom)
    return math.degrees(math.atan(math.sinh(n)))


def is_patch(col: int, row: int) -> bool:
    # Integer hash so the pattern is stable across runs and zoom levels.
    h = (col * 73856093) ^ (row * 19349663)
    return (h & 0xFFFF) % 3 == 0


def grid_hits(values: list[float]) -> list[bool]:
    """True where a grid line falls between this pixel and the next."""
    cells = [math.floor(v / GRID_STEP_DEG) for v in values]
    return [cells[i] != cells[i + 1] for i in range(len(cells) - 1)] + [False]


def render_tile(tx: int, ty: int, zoom: int) -> bytes:
    lons = [x_to_lon(tx + (px + 0.5) / TILE_SIZE, zoom) for px in range(TILE_SIZE)]
    lats = [y_to_lat(ty + (py + 0.5) / TILE_SIZE, zoom) for py in range(TILE_SIZE)]
    cols = [math.floor(lon / PATCH_CELL_DEG) for lon in lons]
    grid_cols = grid_hits(lons)
    grid_rows = grid_hits(lats)

    raw = bytearray()
    for py, lat in enumerate(lats):
        raw.append(0)  # PNG filter type: none
        if grid_rows[py]:
            raw.extend(bytes([GRID]) * TILE_SIZE)
            continue
        row = math.floor(lat / PATCH_CELL_DEG)
        for px in range(TILE_SIZE):
            if grid_cols[px]:
                raw.append(GRID)
            else:
                raw.append(PATCH if is_patch(cols[px], row) else GROUND)
    return encode_png(bytes(raw))


def png_chunk(kind: bytes, data: bytes) -> bytes:
    crc = zlib.crc32(kind + data) & 0xFFFFFFFF
    return struct.pack(">I", len(data)) + kind + data + struct.pack(">I", crc)


def encode_png(raw: bytes) -> bytes:
    # 8-bit indexed color keeps each tile to a few hundred bytes.
    header = struct.pack(">IIBBBBB", TILE_SIZE, TILE_SIZE, 8, 3, 0, 0, 0)
    palette = b"".join(bytes(rgb) for rgb in PALETTE)
    return (
        b"\x89PNG\r\n\x1a\n"
        + png_chunk(b"IHDR", header)
        + png_chunk(b"PLTE", palette)
        + png_chunk(b"IDAT", zlib.compress(raw, 9))
        + png_chunk(b"IEND", b"")
    )


def main() -> None:
    OUTPUT.parent.mkdir(parents=True, exist_ok=True)
    OUTPUT.unlink(missing_ok=True)
    db = sqlite3.connect(OUTPUT)
    db.executescript(
        """
        CREATE TABLE metadata (name TEXT, value TEXT);
        CREATE TABLE tiles (zoom_level INTEGER, tile_column INTEGER,
                            tile_row INTEGER, tile_data BLOB);
        CREATE UNIQUE INDEX tile_index ON tiles (zoom_level, tile_column, tile_row);
        """
    )
    metadata = {
        "name": "vCollect synthetic sample",
        "format": "png",
        "type": "baselayer",
        "version": "1",
        "description": "Synthetic tiles for development. Not a real place.",
        "bounds": f"{WEST},{SOUTH},{EAST},{NORTH}",
        "center": f"0,0,{MIN_ZOOM + 4}",
        "minzoom": str(MIN_ZOOM),
        "maxzoom": str(MAX_ZOOM),
    }
    db.executemany("INSERT INTO metadata VALUES (?, ?)", metadata.items())

    count = 0
    for zoom in range(MIN_ZOOM, MAX_ZOOM + 1):
        x0, x1 = int(lon_to_x(WEST, zoom)), int(lon_to_x(EAST, zoom))
        y0, y1 = int(lat_to_y(NORTH, zoom)), int(lat_to_y(SOUTH, zoom))
        for tx in range(x0, x1 + 1):
            for ty in range(y0, y1 + 1):
                # MBTiles stores rows bottom-up (TMS).
                tms_row = (1 << zoom) - 1 - ty
                db.execute(
                    "INSERT INTO tiles VALUES (?, ?, ?, ?)",
                    (zoom, tx, tms_row, render_tile(tx, ty, zoom)),
                )
                count += 1
    db.commit()
    db.execute("VACUUM")
    db.close()
    print(f"Wrote {count} tiles to {OUTPUT} ({OUTPUT.stat().st_size // 1024} KB)")


if __name__ == "__main__":
    main()
