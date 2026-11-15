import 'package:flutter_test/flutter_test.dart';

import 'helpers/accessibility.dart';
import 'helpers/pump_app.dart';

void main() {
  group('tap-target guidelines (NFR-6)', () {
    testWidgets('app at launch', (tester) async {
      await pumpVCollectApp(tester);
      await expectMeetsTapTargetGuidelines(tester);
    });
  });
}
