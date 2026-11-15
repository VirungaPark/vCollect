import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vcollect/features/search/search_screen.dart';
import 'package:vcollect/strings.dart';

import 'helpers/navigation.dart';
import 'helpers/pump_app.dart';

void main() {
  group('bottom navigation', () {
    testWidgets('launches on Home with the nav bar visible', (tester) async {
      await pumpVCollectApp(tester);

      expect(find.byType(NavigationBar), findsOneWidget);
      expect(find.text(AppStrings.homeDescription), findsOneWidget);
      expect(find.text(AppStrings.searchDescription), findsNothing);
    });

    testWidgets('each destination shows its screen', (tester) async {
      await pumpVCollectApp(tester);

      const tabs = {
        AppStrings.searchTitle: AppStrings.searchDescription,
        AppStrings.mapTitle: AppStrings.mapDescription,
        AppStrings.sendToOfficeTitle: AppStrings.sendToOfficeDescription,
        AppStrings.homeTitle: AppStrings.homeDescription,
      };
      for (final MapEntry(key: label, value: description) in tabs.entries) {
        await tapNavDestination(tester, label);

        expect(find.text(description), findsOneWidget, reason: label);
        for (final other in tabs.values.where((d) => d != description)) {
          expect(find.text(other), findsNothing, reason: label);
        }
      }
    });

    testWidgets('tabs keep their state when switching away and back', (
      tester,
    ) async {
      await pumpVCollectApp(tester);
      await tapNavDestination(tester, AppStrings.searchTitle);
      final before = tester.element(find.byType(SearchScreen));

      await tapNavDestination(tester, AppStrings.mapTitle);
      await tapNavDestination(tester, AppStrings.searchTitle);
      final after = tester.element(find.byType(SearchScreen));

      expect(identical(before, after), isTrue);
    });
  });

  group('screens opened from a tab', () {
    testWidgets('the Home gear opens Settings, and back returns Home', (
      tester,
    ) async {
      await pumpVCollectApp(tester);

      await tester.tap(find.byTooltip(AppStrings.settingsTitle));
      await tester.pumpAndSettle();

      expect(find.text(AppStrings.settingsDescription), findsOneWidget);
      expect(find.text(AppStrings.settingsLanguage), findsOneWidget);
      expect(find.byType(NavigationBar), findsNothing);

      await tester.pageBack();
      await tester.pumpAndSettle();

      expect(find.text(AppStrings.homeDescription), findsOneWidget);
      expect(find.byType(NavigationBar), findsOneWidget);
    });

    testWidgets('Search opens a Farmer file, and back returns to Search', (
      tester,
    ) async {
      await pumpVCollectApp(tester);
      await tapNavDestination(tester, AppStrings.searchTitle);

      await tester.tap(find.text(AppStrings.openFarmerFile));
      await tester.pumpAndSettle();

      expect(find.text(AppStrings.farmerFileDescription), findsOneWidget);

      await tester.pageBack();
      await tester.pumpAndSettle();

      expect(find.text(AppStrings.searchDescription), findsOneWidget);
    });
  });
}
