import 'dart:async';

import 'package:latlong2/latlong.dart';
import 'package:vcollect/features/map/basemap_source.dart';
import 'package:vcollect/features/map/data/sample_field.dart';
import 'package:vcollect/features/map/map_services.dart';
import 'package:vcollect/features/map/position_source.dart';

/// A GPS the test drives by hand with [emit].
class FakePositionSource implements PositionSource {
  FakePositionSource({this.access = LocationAccess.granted});

  /// What the next [requestAccess] answers.
  LocationAccess access;

  int accessRequests = 0;
  final openedSettings = <LocationAccess>[];
  // Sync, so an emitted position is on screen after a single pump.
  final _positions = StreamController<LatLng>.broadcast(sync: true);

  void emit(LatLng position) => _positions.add(position);

  @override
  Future<LocationAccess> requestAccess() async {
    accessRequests++;
    return access;
  }

  @override
  Future<void> openSettings(LocationAccess access) async =>
      openedSettings.add(access);

  @override
  Stream<LatLng> positions() => _positions.stream;
}

/// No basemap, as when the file is missing; the map draws its background.
class NoBasemapSource implements BasemapSource {
  const NoBasemapSource();

  @override
  Future<Basemap?> load() async => null;
}

class FakeFieldsSource implements FieldsSource {
  const FakeFieldsSource([this.fields = sampleFields]);

  final List<SampleField> fields;

  @override
  Future<List<SampleField>> load() async => fields;
}

/// Two synthetic square fields near 0°N 0°E.
const sampleFields = [
  SampleField(
    name: 'Field 1',
    crop: 'Cocoa',
    ring: [
      LatLng(0.001, 0.001),
      LatLng(0.001, 0.003),
      LatLng(0.003, 0.003),
      LatLng(0.003, 0.001),
    ],
  ),
  SampleField(
    name: 'Field 2',
    crop: 'Coffee',
    ring: [
      LatLng(-0.003, -0.003),
      LatLng(-0.003, -0.001),
      LatLng(-0.001, -0.001),
      LatLng(-0.001, -0.003),
    ],
  ),
];

MapServices fakeMapServices({FakePositionSource? positions}) => MapServices(
  positions: positions ?? FakePositionSource(),
  basemap: const NoBasemapSource(),
  fields: const FakeFieldsSource(),
);
