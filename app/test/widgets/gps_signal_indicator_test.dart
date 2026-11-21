import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vcollect/widgets/gps_signal_indicator.dart';
import 'package:vcollect/widgets/signal_level.dart';

import '../helpers/pump_app.dart';

void main() {
  for (final level in SignalLevel.values) {
    testWidgets('${level.name} shows its words and bars', (tester) async {
      await pumpScreen(
        tester,
        Scaffold(
          body: Center(child: GpsSignalIndicator(level: level)),
        ),
      );

      expect(find.text(level.label), findsOneWidget);
      final icon = tester.widget<Icon>(find.byType(Icon));
      expect(icon.icon, level.icon);
      expect(icon.color, level.iconColor);
    });
  }

  testWidgets('screen readers hear the words once, not the bars', (
    tester,
  ) async {
    final handle = tester.ensureSemantics();
    await pumpScreen(
      tester,
      const Scaffold(
        body: Center(child: GpsSignalIndicator(level: SignalLevel.good)),
      ),
    );

    expect(find.bySemanticsLabel(SignalLevel.good.label), findsOneWidget);
    handle.dispose();
  });
}
