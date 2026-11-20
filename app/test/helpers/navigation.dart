import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Finds the bottom navigation destination with [label].
///
/// Tab labels repeat in each screen's app bar and placeholder title, so this
/// looks only inside the [NavigationBar].
Finder navDestination(String label) =>
    find.descendant(of: find.byType(NavigationBar), matching: find.text(label));

/// Taps the bottom navigation destination with [label] and settles.
Future<void> tapNavDestination(WidgetTester tester, String label) async {
  await tester.tap(navDestination(label));
  await tester.pumpAndSettle();
}
