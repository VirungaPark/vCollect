import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_mbtiles/flutter_map_mbtiles.dart';
import 'package:path_provider/path_provider.dart';

/// An offline map ready to draw.
class Basemap {
  const Basemap({
    required this.tileProvider,
    required this.minZoom,
    required this.maxZoom,
  });

  final TileProvider tileProvider;

  /// Zoom levels the file holds tiles for. The map can zoom further in by
  /// enlarging the closest tiles.
  final int minZoom;
  final int maxZoom;
}

/// Where the map's background comes from.
abstract interface class BasemapSource {
  /// The basemap, or null when none can be opened. The map then draws a
  /// plain background, so a missing file never stops the agent working.
  Future<Basemap?> load();
}

/// An MBTiles file bundled as an app asset.
class MbTilesBasemapSource implements BasemapSource {
  const MbTilesBasemapSource({this.asset = 'assets/map/sample.mbtiles'});

  final String asset;

  @override
  Future<Basemap?> load() async {
    try {
      final provider = MbTilesTileProvider.fromPath(
        path: await _copyToStorage(),
        // Missing tiles are normal outside the covered area, not errors.
        silenceTileNotFound: true,
      );
      final metadata = provider.mbtiles.getMetadata();
      return Basemap(
        tileProvider: provider,
        minZoom: metadata.minZoom?.round() ?? 0,
        maxZoom: metadata.maxZoom?.round() ?? 18,
      );
    } on Exception catch (error) {
      debugPrint('Basemap $asset could not be opened: $error');
      return null;
    }
  }

  // SQLite opens files, not assets, so the asset is copied out once.
  Future<String> _copyToStorage() async {
    final bytes = await rootBundle.load(asset);
    final dir = await getApplicationSupportDirectory();
    final name = asset.split('/').last;
    final file = File(
      '${dir.path}${Platform.pathSeparator}maps'
      '${Platform.pathSeparator}$name',
    );
    if (!file.existsSync() || file.lengthSync() != bytes.lengthInBytes) {
      await file.parent.create(recursive: true);
      await file.writeAsBytes(bytes.buffer.asUint8List(), flush: true);
    }
    return file.path;
  }
}
