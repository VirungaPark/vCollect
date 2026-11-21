import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../strings.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';
import '../../widgets/gps_signal_indicator.dart';
import '../../widgets/signal_level.dart';
import 'basemap_source.dart';
import 'data/sample_field.dart';
import 'map_geometry.dart';
import 'map_services.dart';
import 'position_source.dart';
import 'widgets/map_controls.dart';
import 'widgets/position_marker.dart';
import 'widgets/zoom_buttons.dart';

/// Map tab: the agent's position and fields on an offline map.
///
/// A placeholder for Issue #13. Field walks, geofencing and topology
/// checks build on it later; Layers and Go to are stubs until then.
class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  /// Zoom used by My position, close enough to see one field.
  static const positionZoom = 17.0;

  /// Zoom levels allowed past the basemap's own, by enlarging its tiles.
  static const overZoom = 2;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final _mapController = MapController();
  late MapServices _services;
  late final AppLifecycleListener _lifecycle;

  bool _started = false;
  bool _loaded = false;
  Basemap? _basemap;
  List<SampleField> _fields = const [];

  LocationAccess? _access;
  LatLng? _position;
  StreamSubscription<LatLng>? _positionSub;

  @override
  void initState() {
    super.initState();
    _lifecycle = AppLifecycleListener(onResume: _onResume);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _services = MapServicesScope.of(context);

    // The shell builds every tab up front. Waiting until this tab is
    // visible means the location prompt appears on the Map, not at launch,
    // and the GPS rests while another tab is open (NFR-5).
    final visible = Visibility.of(context);
    if (visible && !_started) {
      _started = true;
      _load();
      _requestAccess();
    }
    if (visible) {
      _positionSub?.resume();
    } else if (_positionSub?.isPaused == false) {
      _positionSub?.pause();
    }
  }

  @override
  void dispose() {
    _lifecycle.dispose();
    _positionSub?.cancel();
    _mapController.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final (basemap, fields) = await (
      _services.basemap.load(),
      _services.fields.load(),
    ).wait;
    if (!mounted) return;
    setState(() {
      _basemap = basemap;
      _fields = fields;
      _loaded = true;
    });
  }

  Future<void> _requestAccess() async {
    final access = await _services.positions.requestAccess();
    if (!mounted) return;
    setState(() => _access = access);
    if (access == LocationAccess.granted && _positionSub == null) {
      _positionSub = _services.positions.positions().listen(
        (position) => setState(() => _position = position),
        onError: (Object _) => _restartPositions(),
      );
    }
  }

  // A stream error usually means location was switched off; ask again so
  // the agent sees why the dot stopped.
  void _restartPositions() {
    _positionSub?.cancel();
    _positionSub = null;
    _requestAccess();
  }

  // Only re-check the cases fixed in system settings; re-asking after a
  // plain refusal on every resume would nag the agent.
  void _onResume() {
    if (_access == LocationAccess.deniedForever ||
        _access == LocationAccess.serviceOff) {
      _requestAccess();
    }
  }

  Future<void> _turnOnLocation() async {
    final access = _access;
    if (access == null) return;
    if (access == LocationAccess.denied) {
      await _requestAccess();
    } else {
      await _services.positions.openSettings(access);
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  void _goToMyPosition() {
    final position = _position;
    if (position == null) {
      _showMessage(
        _access == LocationAccess.granted
            ? AppStrings.lookingForPosition
            : AppStrings.locationOff,
      );
      return;
    }
    final zoom = math.max(_mapController.camera.zoom, MapScreen.positionZoom);
    _mapController.move(position, _clampZoom(zoom));
  }

  void _zoomBy(double delta) {
    final camera = _mapController.camera;
    _mapController.move(camera.center, _clampZoom(camera.zoom + delta));
  }

  double get _minZoom => _basemap?.minZoom.toDouble() ?? 3;
  double get _maxZoom =>
      (_basemap?.maxZoom ?? 18).toDouble() + MapScreen.overZoom;
  double _clampZoom(double zoom) => zoom.clamp(_minZoom, _maxZoom);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.mapTitle),
        actions: [
          // Fixed until real signal quality exists; see SignalLevel.
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(right: AppSpacing.pageMargin),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: const GpsSignalIndicator(level: SignalLevel.good),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: _loaded ? _buildMap() : const SizedBox.expand()),
          MapControls(
            onMyPosition: _goToMyPosition,
            onLayers: () => _showMessage(AppStrings.notReadyYet),
            onGoTo: () => _showMessage(AppStrings.notReadyYet),
          ),
        ],
      ),
    );
  }

  Widget _buildMap() {
    final basemap = _basemap;
    final bounds = boundsOf(_fields);
    final position = _position;
    final access = _access;
    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: const LatLng(0, 0),
            initialZoom: 16,
            initialCameraFit: bounds == null
                ? null
                : CameraFit.bounds(
                    bounds: bounds,
                    padding: const EdgeInsets.all(48),
                  ),
            minZoom: _minZoom,
            maxZoom: _maxZoom,
            backgroundColor: AppColors.page,
            // North stays up; a turned map confuses first-time users.
            interactionOptions: const InteractionOptions(
              flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
            ),
          ),
          children: [
            if (basemap != null)
              TileLayer(
                tileProvider: basemap.tileProvider,
                minNativeZoom: basemap.minZoom,
                maxNativeZoom: basemap.maxZoom,
              ),
            PolygonLayer(
              polygons: [
                for (final field in _fields)
                  Polygon(
                    points: field.ring,
                    color: AppColors.olive.withValues(alpha: 0.18),
                    borderColor: AppColors.olive,
                    borderStrokeWidth: 3,
                  ),
              ],
            ),
            MarkerLayer(
              markers: [
                for (final field in _fields)
                  if (field.name case final name?)
                    Marker(
                      point: labelPointOf(field.ring),
                      width: 200,
                      height: 40,
                      child: Center(
                        child: MapLabelPill(
                          text: AppStrings.fieldLabel(name, field.crop),
                        ),
                      ),
                    ),
                if (position != null)
                  Marker(
                    key: const ValueKey('position'),
                    point: position,
                    width: PositionMarker.size.width,
                    height: PositionMarker.size.height,
                    child: const PositionMarker(),
                  ),
              ],
            ),
          ],
        ),
        if (access != null && access != LocationAccess.granted)
          Positioned(
            top: AppSpacing.s12,
            left: AppSpacing.pageMargin,
            right: AppSpacing.pageMargin,
            child: _LocationOffCard(onTurnOn: _turnOnLocation),
          ),
        Positioned(
          right: AppSpacing.pageMargin,
          bottom: AppSpacing.pageMargin,
          child: ZoomButtons(
            onZoomIn: () => _zoomBy(1),
            onZoomOut: () => _zoomBy(-1),
          ),
        ),
      ],
    );
  }
}

/// Says why there is no dot and offers the fix, in plain words.
class _LocationOffCard extends StatelessWidget {
  const _LocationOffCard({required this.onTurnOn});

  final VoidCallback onTurnOn;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.card,
      elevation: 4,
      shadowColor: AppColors.ink,
      borderRadius: BorderRadius.circular(AppRadii.card),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.s16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Row(
              children: [
                Icon(Icons.location_off_outlined, color: AppColors.orange),
                SizedBox(width: AppSpacing.s12),
                Expanded(
                  child: Text(
                    AppStrings.locationOff,
                    style: TextStyle(
                      color: AppColors.ink,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.s12),
            FilledButton(
              style: AppButtonStyles.neutral,
              onPressed: onTurnOn,
              child: const Text(AppStrings.turnOnLocation),
            ),
          ],
        ),
      ),
    );
  }
}
