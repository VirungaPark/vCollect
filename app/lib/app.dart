import 'package:flutter/material.dart';

import 'navigation/app_shell.dart';
import 'strings.dart';

class VCollectApp extends StatelessWidget {
  const VCollectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: AppStrings.appTitle, home: AppShell());
  }
}
