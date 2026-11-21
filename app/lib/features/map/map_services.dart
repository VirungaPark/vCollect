import 'package:flutter/widgets.dart';

import 'basemap_source.dart';
import 'data/sample_field.dart';
import 'position_source.dart';

/// What the Map screen reads from the outside world.
///
/// Kept separate from the screen so tests can swap in fakes without
/// platform plugins. Issue #7 may replace this with the app-wide approach.
class MapServices {
  const MapServices({
    required this.positions,
    required this.basemap,
    required this.fields,
  });

  /// The phone's GPS, the bundled sample map and the sample fields.
  static const real = MapServices(
    positions: GeolocatorPositionSource(),
    basemap: MbTilesBasemapSource(),
    fields: AssetFieldsSource(),
  );

  final PositionSource positions;
  final BasemapSource basemap;
  final FieldsSource fields;
}

/// Makes [MapServices] available to the widgets below it.
class MapServicesScope extends InheritedWidget {
  const MapServicesScope({
    super.key,
    required this.services,
    required super.child,
  });

  final MapServices services;

  static MapServices of(BuildContext context) {
    final scope = context
        .dependOnInheritedWidgetOfExactType<MapServicesScope>();
    assert(scope != null, 'No MapServicesScope above this widget');
    return scope!.services;
  }

  @override
  bool updateShouldNotify(MapServicesScope oldWidget) =>
      services != oldWidget.services;
}
