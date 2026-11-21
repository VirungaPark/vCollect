import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vcollect/app.dart';
import 'package:vcollect/features/map/map_services.dart';
import 'package:vcollect/theme/app_theme.dart';

import 'fake_map_services.dart';

/// Pumps the whole app and waits for the first frame to settle.
///
/// The map uses fakes unless [mapServices] is given, so no test reaches
/// the real GPS or map file.
Future<void> pumpVCollectApp(
  WidgetTester tester, {
  MapServices? mapServices,
}) async {
  await tester.pumpWidget(
    VCollectApp(mapServices: mapServices ?? fakeMapServices()),
  );
  await tester.pumpAndSettle();
}

/// Pumps a single [screen] inside a [MaterialApp] with the app theme, for
/// testing one screen on its own.
Future<void> pumpScreen(
  WidgetTester tester,
  Widget screen, {
  MapServices? mapServices,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      theme: AppTheme.light,
      home: MapServicesScope(
        services: mapServices ?? fakeMapServices(),
        child: screen,
      ),
    ),
  );
  await tester.pumpAndSettle();
}
