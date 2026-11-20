import 'package:flutter/material.dart';

import '../../strings.dart';
import '../../widgets/placeholder_body.dart';

/// Settings, opened from the gear at the top of Home.
///
/// To build: language selection and other app settings. The Language row is
/// a placeholder with no behavior yet.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.settingsTitle)),
      body: const Column(
        children: [
          ListTile(
            leading: Icon(Icons.language),
            title: Text(AppStrings.settingsLanguage),
          ),
          Divider(height: 1),
          Expanded(
            child: PlaceholderBody(
              title: AppStrings.settingsTitle,
              description: AppStrings.settingsDescription,
            ),
          ),
        ],
      ),
    );
  }
}
