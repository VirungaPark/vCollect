import 'package:flutter_test/flutter_test.dart';
import 'package:vcollect/strings.dart';
import 'package:vcollect/widgets/signal_level.dart';

import '../helpers/contrast.dart';

void main() {
  test('each level has its own plain-words label', () {
    expect(SignalLevel.good.label, AppStrings.gpsSignalGood);
    expect(SignalLevel.close.label, AppStrings.gpsSignalWeak);
    expect(SignalLevel.weak.label, AppStrings.gpsSignalTooWeak);
  });

  test('levels differ by icon, not only by color', () {
    final icons = SignalLevel.values.map((level) => level.icon).toSet();
    expect(icons, hasLength(SignalLevel.values.length));
  });

  for (final level in SignalLevel.values) {
    test('${level.name}: label and icon stay readable on the chip', () {
      expect(
        contrastRatio(level.foreground, level.background),
        greaterThanOrEqualTo(4.5),
      );
      expect(
        contrastRatio(level.iconColor, level.background),
        greaterThanOrEqualTo(3),
      );
    });
  }
}
