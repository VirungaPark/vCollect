import 'package:geolocator_platform_interface/geolocator_platform_interface.dart';
import 'package:latlong2/latlong.dart';

/// Whether the app may read the agent's position.
enum LocationAccess {
  granted,

  /// Refused this time; asking again shows the system prompt.
  denied,

  /// Refused for good; only the app's system settings can change it.
  deniedForever,

  /// Location is switched off for the whole phone.
  serviceOff,
}

/// Where the agent's position comes from.
///
/// An interface so an external NMEA receiver (constraint C-8) can replace
/// the phone's GPS without touching the map.
abstract interface class PositionSource {
  /// Asks for access if it has not been decided yet, then reports it.
  Future<LocationAccess> requestAccess();

  /// Opens the system screen that can fix [access].
  Future<void> openSettings(LocationAccess access);

  /// Positions while the app is open. Only listen after access is granted.
  Stream<LatLng> positions();
}

/// The phone's own GPS, through geolocator.
class GeolocatorPositionSource implements PositionSource {
  const GeolocatorPositionSource({GeolocatorPlatform? platform})
    : _platformOverride = platform;

  final GeolocatorPlatform? _platformOverride;

  // Resolved late so a const instance can exist before plugins register.
  GeolocatorPlatform get _platform =>
      _platformOverride ?? GeolocatorPlatform.instance;

  @override
  Future<LocationAccess> requestAccess() async {
    if (!await _platform.isLocationServiceEnabled()) {
      return LocationAccess.serviceOff;
    }
    var permission = await _platform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _platform.requestPermission();
    }
    return switch (permission) {
      LocationPermission.whileInUse ||
      LocationPermission.always => LocationAccess.granted,
      LocationPermission.deniedForever => LocationAccess.deniedForever,
      LocationPermission.denied ||
      LocationPermission.unableToDetermine => LocationAccess.denied,
    };
  }

  @override
  Future<void> openSettings(LocationAccess access) async {
    switch (access) {
      case LocationAccess.serviceOff:
        await _platform.openLocationSettings();
      case LocationAccess.deniedForever:
        await _platform.openAppSettings();
      case LocationAccess.denied || LocationAccess.granted:
        break;
    }
  }

  @override
  Stream<LatLng> positions() => _platform
      .getPositionStream(
        // A small filter keeps the marker steady while the agent stands still.
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 2,
        ),
      )
      .map((position) => LatLng(position.latitude, position.longitude));
}
