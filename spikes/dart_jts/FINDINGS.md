# Findings from dart_jts Spike
This document's purpose is to take note of any findings from building the dart_jts library tests as well as the results of the spike which support the overall decision to use the library for the vCollect project.

**The spike is still under development as of 11/12/26.
The TODOs are as follows listed in priority order:**
- write tests for benchmarks (1k, 10k, 100k coordinates) [out of scope]
- write tests for dart_jts methods (intersection, buffer, etc)
- render tests using flutter (this would allow testing on emulator) [out of scope]
- clean up code + add comments
- fix base circle logic [use .buffer(0)]
- add more shapes [figure eight, etc]

### Notes
- An invalid polygon can become valid using the buffer(0) method from the dart_jts library. This does not guarantee that the original shape is preserved as seen with the bow tie shape test.
- Dart_jts has not been touched since 2023, the dts library is more recent but younger. Recommended approach is a wrapper of dart_jts so that switching libraries in the future is simpler. 

## How to Run Spike (update this once tests are written and files are cleaned up)
open a terminal from dart_jts root directory
```
flutter pub get
cd spikes/dart_jts/bin
dart run generate_data.dart
```

## Tests & Results
### Area & Perimeter Accuracy
### Dart_jts Methods
### Benchmarks
1k, 10k, 100k coordinates


### Does dart_jts conflict with current app's dependencies?
in vCollect/app/ ran `flutter pub get dart_jts --dry-run` and the
results are below, there were no conflicts with the current dependencies. The results only show that some dependencies are locked to specific versions:
```
alex@10-248-26-245 app % flutter pub add dart_jts --dry-run
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
  Try `flutter pub outdated` for more information.
  alex@10-248-26-245 app % flutter pub outdated              
  Showing outdated packages.
  [*] indicates versions that are not the latest available.
```
