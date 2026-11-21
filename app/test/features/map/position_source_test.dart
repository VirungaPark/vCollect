import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator_platform_interface/geolocator_platform_interface.dart';
import 'package:latlong2/latlong.dart';
import 'package:vcollect/features/map/position_source.dart';

/// Answers the way the phone would, and records what was asked.
class _FakeGeolocator extends GeolocatorPlatform {
  _FakeGeolocator({
    this.serviceOn = true,
    this.permission = LocationPermission.whileInUse,
    this.afterRequest = LocationPermission.whileInUse,
  });

  final bool serviceOn;
  final LocationPermission permission;
  final LocationPermission afterRequest;

  int requests = 0;
  final opened = <String>[];

  @override
  Future<bool> isLocationServiceEnabled() async => serviceOn;

  @override
  Future<LocationPermission> checkPermission() async => permission;

  @override
  Future<LocationPermission> requestPermission() async {
    requests++;
    return afterRequest;
  }

  @override
  Future<bool> openAppSettings() async {
    opened.add('app');
    return true;
  }

  @override
  Future<bool> openLocationSettings() async {
    opened.add('location');
    return true;
  }

  @override
  Stream<Position> getPositionStream({LocationSettings? locationSettings}) =>
      Stream.value(
        Position(
          latitude: 0.5,
          longitude: -0.25,
          timestamp: DateTime.utc(2026),
          accuracy: 4,
          altitude: 0,
          altitudeAccuracy: 0,
          heading: 0,
          headingAccuracy: 0,
          speed: 0,
          speedAccuracy: 0,
        ),
      );
}

void main() {
  group('GeolocatorPositionSource.requestAccess', () {
    test('is granted without asking when already allowed', () async {
      final fake = _FakeGeolocator();

      final access = await GeolocatorPositionSource(platform: fake)
          .requestAccess();

      expect(access, LocationAccess.granted);
      expect(fake.requests, 0);
    });

    test('asks once when undecided, and reports the answer', () async {
      final fake = _FakeGeolocator(
        permission: LocationPermission.denied,
        afterRequest: LocationPermission.denied,
      );

      final access = await GeolocatorPositionSource(platform: fake)
          .requestAccess();

      expect(access, LocationAccess.denied);
      expect(fake.requests, 1);
    });

    test('reports a permanent refusal without asking', () async {
      final fake = _FakeGeolocator(
        permission: LocationPermission.deniedForever,
      );

      final access = await GeolocatorPositionSource(platform: fake)
          .requestAccess();

      expect(access, LocationAccess.deniedForever);
      expect(fake.requests, 0);
    });

    test('reports location switched off before checking permission', () async {
      final fake = _FakeGeolocator(
        serviceOn: false,
        permission: LocationPermission.denied,
      );

      final access = await GeolocatorPositionSource(platform: fake)
          .requestAccess();

      expect(access, LocationAccess.serviceOff);
      expect(fake.requests, 0);
    });
  });

  test('openSettings opens the screen that can fix the problem', () async {
    final fake = _FakeGeolocator();
    final source = GeolocatorPositionSource(platform: fake);

    await source.openSettings(LocationAccess.serviceOff);
    await source.openSettings(LocationAccess.deniedForever);
    await source.openSettings(LocationAccess.denied);

    expect(fake.opened, ['location', 'app']);
  });

  test('positions are converted to latitude/longitude', () async {
    final source = GeolocatorPositionSource(platform: _FakeGeolocator());

    expect(await source.positions().first, const LatLng(0.5, -0.25));
  });
}
