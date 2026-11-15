import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vcollect/app.dart';

/// Pumps the whole app and waits for the first frame to settle.
Future<void> pumpVCollectApp(WidgetTester tester) async {
  await tester.pumpWidget(const VCollectApp());
  await tester.pumpAndSettle();
}

/// Pumps a single [screen] inside a bare [MaterialApp], for testing one
/// screen on its own.
Future<void> pumpScreen(WidgetTester tester, Widget screen) async {
  await tester.pumpWidget(MaterialApp(home: screen));
  await tester.pumpAndSettle();
}
