import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:vcollect/features/map/map_screen.dart';
import 'package:vcollect/features/map/position_source.dart';
import 'package:vcollect/strings.dart';

import '../../helpers/fake_map_services.dart';
import '../../helpers/navigation.dart';
import '../../helpers/pump_app.dart';

Future<FakePositionSource> _pumpMap(
  WidgetTester tester, {
  LocationAccess access = LocationAccess.granted,
}) async {
  final positions = FakePositionSource(access: access);
  await pumpScreen(
    tester,
    const MapScreen(),
    mapServices: fakeMapServices(positions: positions),
  );
  return positions;
}

MapCamera _camera(WidgetTester tester) =>
    tester.widget<FlutterMap>(find.byType(FlutterMap)).mapController!.camera;

Marker? _positionMarker(WidgetTester tester) => tester
    .widget<MarkerLayer>(find.byType(MarkerLayer))
    .markers
    .where((marker) => marker.key == const ValueKey('position'))
    .firstOrNull;

/// Lets a snack bar run out, so no timer is left when the test ends.
Future<void> _dismissSnackBar(WidgetTester tester) async {
  await tester.pump(const Duration(seconds: 5));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('shows the map, the signal and every button', (tester) async {
    await _pumpMap(tester);

    expect(find.byType(FlutterMap), findsOneWidget);
    expect(find.text(AppStrings.gpsSignalGood), findsOneWidget);
    for (final label in [
      AppStrings.myPosition,
      AppStrings.layers,
      AppStrings.goTo,
    ]) {
      expect(find.text(label), findsOneWidget, reason: label);
    }
    expect(find.byTooltip(AppStrings.zoomIn), findsOneWidget);
    expect(find.byTooltip(AppStrings.zoomOut), findsOneWidget);
  });

  testWidgets('draws and labels each sample field', (tester) async {
    await _pumpMap(tester);

    final polygons = tester
        .widget<PolygonLayer>(find.byType(PolygonLayer))
        .polygons;
    expect(polygons, hasLength(sampleFields.length));
    expect(find.text('Field 1 (Cocoa)'), findsOneWidget);
    expect(find.text('Field 2 (Coffee)'), findsOneWidget);
  });

  testWidgets('starts with every field in view', (tester) async {
    await _pumpMap(tester);

    final visible = _camera(tester).visibleBounds;
    for (final field in sampleFields) {
      for (final corner in field.ring) {
        expect(visible.contains(corner), isTrue, reason: '$corner');
      }
    }
  });

  testWidgets('the position marker appears and follows the agent', (
    tester,
  ) async {
    final positions = await _pumpMap(tester);
    expect(_positionMarker(tester), isNull);
    expect(find.text(AppStrings.youAreHere), findsNothing);

    positions.emit(const LatLng(0.002, 0.002));
    await tester.pump();

    expect(_positionMarker(tester)?.point, const LatLng(0.002, 0.002));
    expect(find.text(AppStrings.youAreHere), findsOneWidget);

    positions.emit(const LatLng(0.0021, 0.0025));
    await tester.pump();

    expect(_positionMarker(tester)?.point, const LatLng(0.0021, 0.0025));
  });

  testWidgets('My position brings the map back to the agent', (tester) async {
    final positions = await _pumpMap(tester);
    const agent = LatLng(-0.002, -0.002);
    positions.emit(agent);
    await tester.pump();
    expect(_camera(tester).center, isNot(agent));

    await tester.tap(find.text(AppStrings.myPosition));
    await tester.pump();

    expect(_camera(tester).center.latitude, closeTo(agent.latitude, 1e-9));
    expect(_camera(tester).center.longitude, closeTo(agent.longitude, 1e-9));
    expect(_camera(tester).zoom, greaterThanOrEqualTo(MapScreen.positionZoom));
  });

  testWidgets('My position before any fix says it is still looking', (
    tester,
  ) async {
    await _pumpMap(tester);

    await tester.tap(find.text(AppStrings.myPosition));
    await tester.pump();

    expect(find.text(AppStrings.lookingForPosition), findsOneWidget);
    await _dismissSnackBar(tester);
  });

  testWidgets('+ and - zoom one step and stop at the limits', (tester) async {
    await _pumpMap(tester);
    final start = _camera(tester).zoom;

    await tester.tap(find.byTooltip(AppStrings.zoomIn));
    await tester.pump();
    expect(_camera(tester).zoom, closeTo(start + 1, 1e-9));

    await tester.tap(find.byTooltip(AppStrings.zoomOut));
    await tester.pump();
    expect(_camera(tester).zoom, closeTo(start, 1e-9));

    for (var i = 0; i < 30; i++) {
      await tester.tap(find.byTooltip(AppStrings.zoomOut));
      await tester.pump();
    }
    final min = _camera(tester).zoom;
    await tester.tap(find.byTooltip(AppStrings.zoomOut));
    await tester.pump();
    expect(_camera(tester).zoom, min);

    for (var i = 0; i < 30; i++) {
      await tester.tap(find.byTooltip(AppStrings.zoomIn));
      await tester.pump();
    }
    final max = _camera(tester).zoom;
    await tester.tap(find.byTooltip(AppStrings.zoomIn));
    await tester.pump();
    expect(_camera(tester).zoom, max);
    expect(max, greaterThan(min));
  });

  for (final stub in [AppStrings.layers, AppStrings.goTo]) {
    testWidgets('$stub says it is not ready yet', (tester) async {
      await _pumpMap(tester);

      await tester.tap(find.text(stub));
      await tester.pump();

      expect(find.text(AppStrings.notReadyYet), findsOneWidget);
      expect(tester.takeException(), isNull);
      await _dismissSnackBar(tester);
    });
  }

  group('when location is refused', () {
    testWidgets('a card explains how to turn it on', (tester) async {
      await _pumpMap(tester, access: LocationAccess.denied);

      expect(find.text(AppStrings.locationOff), findsOneWidget);
      expect(find.text(AppStrings.turnOnLocation), findsOneWidget);
    });

    testWidgets('Turn on location asks again after a plain refusal', (
      tester,
    ) async {
      final positions = await _pumpMap(tester, access: LocationAccess.denied);
      expect(positions.accessRequests, 1);

      positions.access = LocationAccess.granted;
      await tester.tap(find.text(AppStrings.turnOnLocation));
      await tester.pumpAndSettle();

      expect(positions.accessRequests, 2);
      expect(find.text(AppStrings.locationOff), findsNothing);
    });

    testWidgets('Turn on location opens settings after a final refusal', (
      tester,
    ) async {
      final positions = await _pumpMap(
        tester,
        access: LocationAccess.deniedForever,
      );

      await tester.tap(find.text(AppStrings.turnOnLocation));
      await tester.pumpAndSettle();

      expect(positions.openedSettings, [LocationAccess.deniedForever]);
    });

    testWidgets('My position points to the card instead of searching', (
      tester,
    ) async {
      await _pumpMap(tester, access: LocationAccess.serviceOff);

      await tester.tap(find.text(AppStrings.myPosition));
      await tester.pump();

      // Once in the card, once in the snack bar.
      expect(find.text(AppStrings.locationOff), findsNWidgets(2));
      await _dismissSnackBar(tester);
    });
  });

  group('inside the app', () {
    testWidgets('location is only requested once the Map tab opens', (
      tester,
    ) async {
      final positions = FakePositionSource();
      await pumpVCollectApp(
        tester,
        mapServices: fakeMapServices(positions: positions),
      );
      expect(positions.accessRequests, 0);

      await tapNavDestination(tester, AppStrings.mapTitle);

      expect(positions.accessRequests, 1);
    });

    testWidgets('fits a phone at the largest text size', (tester) async {
      // A typical phone (411 x 914 dp) with the system font scale at 200%.
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.625;
      tester.platformDispatcher.textScaleFactorTestValue = 2.0;
      addTearDown(tester.view.reset);
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      final positions = FakePositionSource(access: LocationAccess.denied);

      await pumpVCollectApp(
        tester,
        mapServices: fakeMapServices(positions: positions),
      );
      await tapNavDestination(tester, AppStrings.mapTitle);
      positions.emit(const LatLng(0, 0));
      await tester.pump();

      expect(tester.takeException(), isNull);
      expect(find.text(AppStrings.myPosition), findsOneWidget);
    });
  });
}
