import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vcollect/features/settings/languages_screen.dart';
import 'package:vcollect/features/settings/settings_screen.dart';
import 'package:vcollect/strings.dart';

import '../../helpers/pump_app.dart';

void main() {
  group('Settings Screen Widget Tests', () {
    testWidgets('renders all settings sections and initial tile states', (
      tester,
    ) async {
      await pumpScreen(tester, const SettingsScreen());
      // verify AppBar title
      expect(find.text(AppStrings.settingsTitle), findsOneWidget);

      // verify section headers
      expect(find.text(AppStrings.settingsGeneral), findsOneWidget);
      expect(find.text(AppStrings.settingsStorage), findsOneWidget);
      expect(find.text(AppStrings.settingsAccount), findsOneWidget);

      // verify general section tiles rendered
      expect(find.text(AppStrings.settingsLanguage), findsOneWidget);
      expect(find.text(AppStrings.settingsNotifications), findsOneWidget);
      expect(find.text(AppStrings.settingsLocation), findsOneWidget);
      expect(find.text(AppStrings.settingsEnableCellular), findsOneWidget);

      // verify storage section tiles rendered
      expect(find.text(AppStrings.settingsStorageSpace), findsOneWidget);
      expect(find.text(AppStrings.settingsCampaignPackages), findsOneWidget);
      expect(
        find.text(AppStrings.settingsViewCampaignPackages),
        findsOneWidget,
      );

      // verify account section tiles rendered
      expect(find.text(AppStrings.settingsEmail), findsOneWidget);
      expect(find.text(AppStrings.settingsPassword), findsOneWidget);
      expect(find.text(AppStrings.settingsLogout), findsOneWidget);

      // scroll to make Misc. section visible
      final bugFinder = find.text(AppStrings.settingsReportBug);
      await tester.scrollUntilVisible(bugFinder, 50);
      // verify misc section header rendered
      expect(find.text(AppStrings.settingsMisc), findsOneWidget);
      // verify misc section tiles rendered
      expect(find.text(AppStrings.settingsAbout), findsOneWidget);
      expect(find.text(AppStrings.settingsTerms), findsOneWidget);
      expect(find.text(AppStrings.settingsLicenses), findsOneWidget);
      expect(find.text(AppStrings.settingsReportBug), findsOneWidget);
    });

    testWidgets('toggling settings switches updates their state', (
      tester,
    ) async {
      await pumpScreen(tester, const SettingsScreen());

      final notificationsFinder = find.widgetWithText(
        SwitchListTile,
        AppStrings.settingsNotifications,
      );

      // Tap notifications switch to enable it
      await tester.tap(notificationsFinder);
      await tester.pump();

      final updatedNotificationsTile = tester.widget<SwitchListTile>(
        notificationsFinder,
      );
      expect(updatedNotificationsTile.value, isTrue);

      // Toggle back off
      await tester.tap(notificationsFinder);
      await tester.pump();

      expect(tester.widget<SwitchListTile>(notificationsFinder).value, isFalse);
    });

    testWidgets(
      'tapping language tile opens LanguagesScreen and updates language on return',
      (tester) async {
        await pumpScreen(tester, const SettingsScreen());

        // Tap Language tile to push LanguagesScreen
        await tester.tap(find.text(AppStrings.settingsLanguage));
        await tester.pumpAndSettle();

        // Verify LanguagesScreen is visible
        expect(find.byType(LanguagesScreen), findsOneWidget);
        expect(find.text(AppStrings.languages[1]), findsOneWidget); // 'French'

        // Select 'French'
        await tester.tap(find.text(AppStrings.languages[1]));
        await tester.pump();

        // Navigate back
        await tester.tap(find.byIcon(Icons.arrow_back));
        await tester.pumpAndSettle();

        // Verify return to SettingsScreen with updated language subtitle
        expect(find.byType(SettingsScreen), findsOneWidget);
        expect(find.text(AppStrings.languages[1]), findsOneWidget);
      },
    );

    testWidgets(
      'tapping placeholder tiles shows a SnackBar with "This is not ready yet."',
      (tester) async {
        await pumpScreen(tester, const SettingsScreen());

        // set finders for each settings tile
        final emailFinder = find.text(AppStrings.settingsEmail);

        // Scroll the ListView until Email is physically inside the viewport
        await tester.ensureVisible(emailFinder);
        await tester.pumpAndSettle();

        await tester.tap(emailFinder);
        await tester.pump(); // Trigger SnackBar presentation

        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.text(AppStrings.notReadyYet), findsOneWidget);
      },
    );

    testWidgets('scrolls down to display Misc. section items', (tester) async {
      await pumpScreen(tester, const SettingsScreen());

      final bugFinder = find.text(AppStrings.settingsReportBug);
      await tester.scrollUntilVisible(bugFinder, 50);

      expect(bugFinder, findsOneWidget);
      expect(find.text(AppStrings.settingsMisc), findsOneWidget);
    });
  });
}
