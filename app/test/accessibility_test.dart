import 'package:flutter_test/flutter_test.dart';
import 'package:vcollect/strings.dart';

import 'helpers/accessibility.dart';
import 'helpers/navigation.dart';
import 'helpers/pump_app.dart';

void main() {
  group('tap-target guidelines (NFR-6)', () {
    group('tabs', () {
      for (final tab in [
        AppStrings.homeTitle,
        AppStrings.searchTitle,
        AppStrings.mapTitle,
        AppStrings.sendToOfficeTitle,
      ]) {
        testWidgets(tab, (tester) async {
          await pumpVCollectApp(tester);
          await tapNavDestination(tester, tab);

          await expectMeetsTapTargetGuidelines(tester);
        });
      }
    });

    testWidgets('Settings', (tester) async {
      await pumpVCollectApp(tester);
      await tester.tap(find.byTooltip(AppStrings.settingsTitle));
      await tester.pumpAndSettle();

      await expectMeetsTapTargetGuidelines(tester);
    });

    testWidgets('Farmer file', (tester) async {
      await pumpVCollectApp(tester);
      await tapNavDestination(tester, AppStrings.searchTitle);
      await tester.tap(find.text(AppStrings.openFarmerFile));
      await tester.pumpAndSettle();

      await expectMeetsTapTargetGuidelines(tester);
    });
  });
}
