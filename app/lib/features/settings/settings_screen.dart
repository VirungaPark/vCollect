import 'package:flutter/material.dart';

import '../../strings.dart';
import '../../theme/app_theme.dart';
import 'languages_screen.dart';
import 'settings_section.dart';

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
  bool _notificationsValue = false;
  final double _progressValue = 0.63;
  String _currentLanguage = AppStrings.languages[0]; // pull from phone prefs

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
  // temp method for limited persistence
  Future<void> _changeCurrentLanguage(String language) async {
    final selectedLanguage = await Navigator.of(context).push<String>(
      MaterialPageRoute<String>(builder: (_) =>
        LanguagesScreen(currentLanguage: _currentLanguage)
      ),
    );
    if (selectedLanguage != null) {
      setState(() => _currentLanguage = selectedLanguage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.settingsTitle)),
      body: ListView(
        children: <Widget>[
          // general settings
          SettingsSection(title: AppStrings.settingsGeneral, children: [
            ListTile(
              title: const Text(AppStrings.settingsLanguage),
              subtitle: Text('Current: $_currentLanguage'),
              leading: const Icon(Icons.language),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _changeCurrentLanguage(_currentLanguage),
            ),
            SwitchListTile(
              title: const Text(AppStrings.settingsNotifications),
              subtitle: const Text(AppStrings.settingsNotificationsDescription),
              secondary: const Icon(Icons.notifications),
              value: _notificationsValue,
              onChanged: (bool value) => setState(() => _notificationsValue = value),
            ),
          ]),
          // storage settings
          SettingsSection(title: AppStrings.settingsStorage, children: [
            // TODO: implement dynamic storage breakdown
            ListTile(
              title: Text(AppStrings.settingsStorageSpace),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: AppSpacing.s8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadii.card),
                  child: LinearProgressIndicator(value: _progressValue),
                ),
              ),
              leading: const Icon(Icons.storage),
              trailing: Text('6 of 10 GB'),
            ),
            ListTile(
              title: Text(AppStrings.settingsCampaignPackages),
              subtitle: Text(AppStrings.settingsViewCampaignPackages),
              leading: const Icon(Icons.map),
              trailing: const Icon(Icons.chevron_right),
            ),
          ]),
          // account settings
          SettingsSection(title: AppStrings.settingsAccount, children: [
            ListTile(
              title: const Text(AppStrings.settingsEmail),
              subtitle: const Text(AppStrings.settingsEmailDescription),
              leading: const Icon(Icons.email),
              trailing: const Icon(Icons.edit),
              onTap: () => _showMessage(AppStrings.notReadyYet),
            ),
            ListTile(
              title: const Text(AppStrings.settingsPassword),
              subtitle: const Text(AppStrings.settingsPasswordDescription),
              leading: const Icon(Icons.lock),
              trailing: const Icon(Icons.edit),
              onTap: () => _showMessage(AppStrings.notReadyYet),
            ),
          ])
        ],
      ),
    );
  }
}
