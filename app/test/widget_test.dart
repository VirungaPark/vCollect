import 'package:flutter_test/flutter_test.dart';

import 'package:vcollect/main.dart';

void main() {
  testWidgets('shows the hello world text', (WidgetTester tester) async {
    await tester.pumpWidget(const VCollectApp());

    expect(find.text('Hello, world'), findsOneWidget);
  });
}
