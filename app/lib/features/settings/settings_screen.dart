import 'package:flutter/material.dart';

import '../../strings.dart';
import '../../widgets/placeholder_body.dart';

/// Settings, opened from the gear at the top of Home.
///
/// To build: language selection and other app settings. The Language row is
/// a placeholder with no behavior yet.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _languageValue = false;
  bool _notificationsValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.settingsTitle)),
      body: ListView(
        children: <Widget>[
          SwitchListTile(
            title: const Text(AppStrings.settingsLanguage),
            secondary: const Icon(Icons.language),
            value: _languageValue,
            onChanged: (bool value) => setState(() => _languageValue = value),
          ),
          SwitchListTile(
            title: const Text('Enable notifications'),
            subtitle: const Text('Receive notifications from vCollect'),
            secondary: const Icon(Icons.notifications),
            value: _notificationsValue,
            onChanged: (bool value) => setState(() => _notificationsValue = value),
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
