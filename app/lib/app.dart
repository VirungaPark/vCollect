import 'package:flutter/material.dart';

import 'navigation/app_shell.dart';
import 'strings.dart';
import 'theme/app_theme.dart';

class VCollectApp extends StatelessWidget {
  const VCollectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appTitle,
      theme: AppTheme.light,
      home: const AppShell(),
    );
  }
}
