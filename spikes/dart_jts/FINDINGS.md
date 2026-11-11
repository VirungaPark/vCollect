Does dart_jts conflict with current app's dependencies?
in vCollect/app/ ran `flutter pub get dart_jts --dry-run` and the
results are below:
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
