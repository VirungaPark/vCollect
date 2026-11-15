import 'package:flutter/material.dart';

import '../../strings.dart';
import '../../widgets/placeholder_body.dart';
import '../settings/settings_screen.dart';

/// Home tab: the agent's starting point.
///
/// To build: pending work as list tiles (not cards), quick links and the
/// New farmer button. Language selection lives in Settings (the gear), not
/// at the top of this page.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.homeTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: AppStrings.settingsTitle,
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(builder: (_) => const SettingsScreen()),
            ),
          ),
        ],
      ),
      body: const PlaceholderBody(
        title: AppStrings.homeTitle,
        description: AppStrings.homeDescription,
      ),
    );
  }
}
