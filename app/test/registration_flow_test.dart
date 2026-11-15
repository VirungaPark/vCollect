import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vcollect/features/registration/registration_step.dart';
import 'package:vcollect/strings.dart';

import 'helpers/pump_app.dart';

Future<void> _openRegistration(WidgetTester tester) async {
  await pumpVCollectApp(tester);
  await tester.tap(find.text(AppStrings.newFarmer));
  await tester.pumpAndSettle();
}

Future<void> _tapNext(WidgetTester tester) async {
  await tester.tap(find.text(AppStrings.next));
  await tester.pumpAndSettle();
}

/// Expects [step]'s screen to be the one showing.
void _expectOnStep(RegistrationStep step) {
  final total = RegistrationStep.values.length;
  expect(find.text(AppStrings.stepOf(step.number, total)), findsOneWidget);
  expect(find.text(step.description), findsOneWidget);
}

void main() {
  group('registration flow', () {
    testWidgets('New farmer opens step 1 without the bottom nav bar', (
      tester,
    ) async {
      await _openRegistration(tester);

      _expectOnStep(RegistrationStep.findFarmer);
      expect(find.byType(NavigationBar), findsNothing);
    });

    testWidgets('Next walks through every step in order', (tester) async {
      await _openRegistration(tester);

      for (final step in RegistrationStep.values) {
        _expectOnStep(step);
        if (step != RegistrationStep.values.last) {
          await _tapNext(tester);
        }
      }
      expect(find.text(AppStrings.next), findsNothing);
      expect(find.text(AppStrings.done), findsOneWidget);
    });

    testWidgets('Back returns to the previous step', (tester) async {
      await _openRegistration(tester);
      await _tapNext(tester);
      _expectOnStep(RegistrationStep.idCard);

      await tester.pageBack();
      await tester.pumpAndSettle();

      _expectOnStep(RegistrationStep.findFarmer);
    });

    testWidgets('Done on the last step returns to Home', (tester) async {
      await _openRegistration(tester);
      for (var i = 1; i < RegistrationStep.values.length; i++) {
        await _tapNext(tester);
      }

      await tester.tap(find.text(AppStrings.done));
      await tester.pumpAndSettle();

      expect(find.text(AppStrings.homeDescription), findsOneWidget);
      expect(find.byType(NavigationBar), findsOneWidget);
    });
  });

  group('step indicator tooltips', () {
    testWidgets('every step icon has a tooltip with the step name', (
      tester,
    ) async {
      await _openRegistration(tester);

      for (final step in RegistrationStep.values) {
        expect(find.byTooltip(step.title), findsOneWidget, reason: step.name);
      }
    });

    testWidgets('a step name shows only after its icon is tapped', (
      tester,
    ) async {
      await _openRegistration(tester);
      final fieldWalk = RegistrationStep.fieldWalk;

      expect(find.text(fieldWalk.title), findsNothing);

      await tester.tap(find.byTooltip(fieldWalk.title));
      await tester.pump();

      expect(find.text(fieldWalk.title), findsOneWidget);

      // Let the tooltip hide again so no timers are left pending.
      await tester.pumpAndSettle(const Duration(seconds: 2));
    });
  });

  testWidgets('Find the farmer does not show the cache count or zone', (
    tester,
  ) async {
    // Partner feedback on the demos: these belong on the backdrop, if at all.
    await _openRegistration(tester);

    expect(find.textContaining('local records'), findsNothing);
    expect(find.textContaining('Cache active'), findsNothing);
  });
}
