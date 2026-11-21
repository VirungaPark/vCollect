import 'package:flutter/material.dart';

import 'features/map/map_services.dart';
import 'navigation/app_shell.dart';
import 'strings.dart';
import 'theme/app_theme.dart';

class VCollectApp extends StatelessWidget {
  const VCollectApp({super.key, this.mapServices = MapServices.real});

  /// Replaced with fakes in tests, so no platform plugins are needed.
  final MapServices mapServices;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appTitle,
      theme: AppTheme.light,
      home: const AppShell(),
      // Above the navigator, so screens pushed later can reach it too.
      builder: (context, child) =>
          MapServicesScope(services: mapServices, child: child!),
    );
  }
}
