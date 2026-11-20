import 'package:flutter_test/flutter_test.dart';

/// Checks the screen currently pumped in [tester] against Flutter's
/// tap-target guidelines (NFR-6): every tappable element is at least
/// 48 x 48 dp and has a label for screen readers.
Future<void> expectMeetsTapTargetGuidelines(WidgetTester tester) async {
  final handle = tester.ensureSemantics();
  try {
    await tester.pump();
    await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
  } finally {
    handle.dispose();
  }
}
