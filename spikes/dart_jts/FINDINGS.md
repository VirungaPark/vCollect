# dart_jts Spike: Findings (Issue #12)

## Purpose

vCollect needs to turn GPS traces into valid field boundaries with a reliable area and perimeter. This spike evaluates whether the `dart_jts` library, a Dart port of the Java Topology Suite, can do that, and what we would need to put around it to use it safely.

**Status:** In progress as of November 12, 2026. Items in [brackets] are waiting on test output or a team decision.

## Recommendation

We recommend adopting `dart_jts` behind a thin wrapper of our own.

The library covers the checks we depend on today. Its main weakness is maintenance: the latest release, 0.3.0+1, dates from 2023 and nothing has been published since. The alternative we know of, `dts`, is more recent but newer and unproven, and we have not tested it. Wrapping `dart_jts` lets us use it now and switch libraries later, if Virunga prefers, without rewriting the app.

This recommendation may change if we later test `dts`, which the team has deferred to a future spike.

## What we tested

All tests live in `jts_test.dart` and run with `dart test -r expanded`.

- **Polygon validity.** Clean square, triangle and L-shape traces are accepted as valid. A bow tie, which crosses itself, is rejected as invalid.
- **Area and perimeter.** For clean and noisy versions of each shape, we compare the library's area and length against the shoelace formula.
- **Spatial relationships.** Intersection, disjointness, touching boundaries, containment (polygons and points) and equality.
- **Centroid.** The centroid of a 100 m square.

Not yet covered: envelope, `buffer`, the geometry returned by `intersection()`, unclosed traces, duplicate points, and GeoJSON import and export.

## Test environment

The spike is a standalone Dart package (`vcollect_dart_jts_spike`), kept separate from the app so it can be run and discarded without touching the app's dependencies. The versions below come from its `pubspec.yaml` and `pubspec.lock`.

| Component | Version |
|---|---|
| `dart_jts` | 0.3.0+1 (the latest release) |
| `vector_math` | 2.4.4 |
| `test` (dev) | 1.33.0, with `test_api` 0.7.15 |
| Dart SDK | 3.13.7 or later |
| Flutter | 3.47.9, the version CI installs |

The spike has only three direct dependencies. The lock file also resolved `intl` 0.20.3 as a transitive dependency, which is the version the app already uses.

One difference to keep in mind: the dry run in the app (below) shows `vector_math` locked at 2.4.0 and `test_api` at 0.7.12, because the app's Flutter SDK pins them. The spike resolves newer versions of both. Nothing suggests this affects `dart_jts` itself, which resolved to 0.3.0+1 in both places. Still, if the tests are ever moved into the app, `vector_math` would need to be relaxed to a version the app allows (for example `^2.4.0`), and the tests should be rerun there.

## Results


| Acceptance criterion | Outcome |
|---|---|
| Area and perimeter within X% of ground truth | [Pending. The team still needs to set X.] |
| Invalid polygons are detected | [Pending. Based on the bow tie test.] |
| Self-intersections are repaired where viable | Partly. `buffer(0)` produces a valid polygon, but it does not always preserve the original shape (see Notes). |
| Processing time under Y ms on the target device | Deferred to a later spike. |

### Compatibility with the app's dependencies

`dart_jts` does not conflict with the app's current dependencies. From `vCollect/app/` we ran `flutter pub add dart_jts --dry-run`. Adding the package would change two dependencies, and some packages are pinned to specific versions, but nothing failed to resolve.

```
Resolving dependencies...
Downloading packages...
dart_jts 0.3.0+1
intl 0.20.3
  material_color_utilities 0.13.0 (0.13.1 available)
  meta 1.18.3 (1.19.0 available)
  test_api 0.7.12 (0.7.15 available)
  vector_math 2.4.0 (2.4.4 available)
Would change 2 dependencies.
4 packages have newer versions incompatible with dependency constraints.
```


## Notes

- `buffer(0)` can turn an invalid polygon into a valid one, but it can change the shape in the process. The bow tie test shows this: the repaired polygon is valid, but it is not the shape the surveyor walked.
- The coordinates in these tests are planar. Converting latitude and longitude to meters is outside this spike, as the issue specifies.

### Improvements to the test suite

- **Noisy-shape test.** It currently compares the library's result with the shoelace formula on the same points at a very tight tolerance. That confirms the library computes correctly, but it does not show accuracy against a known real-world value. Adding checks against known answers would be stronger: a 100 m square has an area of 10,000 m² and a perimeter of 400 m, and an equilateral triangle's area is (√3 / 4) times the side squared.
- **Centroid test.** It builds a triangle it never uses and only checks the square. The unused code should be removed, or the triangle tested.
- **Side lengths.** The area tests take their side length from a seeded random number. Fixed, round values would make failures easier to read.

## Running the spike

From `vCollect/spikes/dart_jts/`:

```
flutter pub get
dart test -r expanded
```

This section will be updated once the tests are cleaned up.

## Remaining work
1. Add tests for envelope, `buffer`, `intersection()`, unclosed traces and duplicate points.
2. Check GeoJSON support, and write a simple converter if it is missing.
3. Run the CI license check described above.
4. Find the exact points where a trace intersects itself, using the error method. This may need custom logic.
5. Fix the base circle logic (use `buffer(0)`) and add more shapes, such as a figure eight.
6. Clean up the code and add comments.

Already done: tests for polygon intersection, containment and validity.

Out of scope or deferred: benchmarks at 1,000, 10,000 and 100,000 coordinates; tests of `dts`; rendering tests in Flutter on an emulator.
