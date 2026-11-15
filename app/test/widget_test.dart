import 'package:flutter_test/flutter_test.dart';

import 'package:vcollect/app.dart';
import 'package:vcollect/strings.dart';

void main() {
  testWidgets('shows the home placeholder', (WidgetTester tester) async {
    await tester.pumpWidget(const VCollectApp());

    expect(find.text(AppStrings.homeDescription), findsOneWidget);
  });
}
