import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vcollect/strings.dart';
import 'package:vcollect/widgets/placeholder_body.dart';

import 'helpers/pump_app.dart';

void main() {
  testWidgets('the app builds and shows the home placeholder', (tester) async {
    await pumpVCollectApp(tester);

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.text(AppStrings.homeDescription), findsOneWidget);
  });

  testWidgets('PlaceholderBody shows its title and description', (
    tester,
  ) async {
    await pumpScreen(
      tester,
      const Scaffold(
        body: PlaceholderBody(title: 'A title', description: 'A description'),
      ),
    );

    expect(find.text('A title'), findsOneWidget);
    expect(find.text('A description'), findsOneWidget);
  });
}
