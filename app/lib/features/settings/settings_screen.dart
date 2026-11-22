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
  // initial state for settings
  // TODO: set state from local storage
  bool _notificationsValue = false;
  bool _locationValue = false;
  bool _cellularValue = false;
  final double _progressValue = 0.6;
  String _currentLanguage = AppStrings.languages[0];

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
            SwitchListTile(
              title: const Text(AppStrings.settingsLocation),
              subtitle: const Text(AppStrings.settingsLocationDescription),
              secondary: const Icon(Icons.location_on),
              value: _locationValue,
              onChanged:
                  (bool value) => setState(() => _locationValue = value),
            ),
            SwitchListTile(
              title: const Text(AppStrings.settingsEnableCellular),
              subtitle: const Text(AppStrings.settingsEnableCellularDescription),
              secondary: const Icon(Icons.signal_cellular_alt),
              value: _cellularValue,
              onChanged:
                  (bool value) => setState(() => _cellularValue = value),
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
            // TODO: implement this page once local storage is implemented
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
            ListTile(
              title: const Text(AppStrings.settingsLogout),
              subtitle: const Text(AppStrings.settingsLogoutDescription),
              leading: const Icon(Icons.logout),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _showMessage(AppStrings.notReadyYet),
            ),
          ]),
          // misc settings
          // TODO: implement once files exist
          SettingsSection(title: AppStrings.settingsMisc, children: [
            ListTile(
              title: const Text(AppStrings.settingsAbout),
              subtitle: const Text(AppStrings.settingsAboutDescription),
              leading: const Icon(Icons.bookmark),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _showMessage(AppStrings.notReadyYet),
            ),
            ListTile(
              title: const Text(AppStrings.settingsTerms),
              subtitle: const Text(AppStrings.settingsTermsDescription),
              leading: const Icon(Icons.description),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _showMessage(AppStrings.notReadyYet),
            ),
            ListTile(
              title: const Text(AppStrings.settingsLicenses),
              subtitle: const Text(AppStrings.settingsLicensesDescription),
              leading: const Icon(Icons.copyright),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _showMessage(AppStrings.notReadyYet),
            ),
            ListTile(
              title: const Text(AppStrings.settingsReportBug),
              subtitle: const Text(AppStrings.settingsReportBugDescription),
              leading: const Icon(Icons.bug_report),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _showMessage(AppStrings.notReadyYet),
            ),
          ])
        ],
      ),
    );
  }
}