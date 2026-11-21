import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vcollect/theme/app_colors.dart';

import '../helpers/contrast.dart';

void main() {
  test('contrastRatio matches known WCAG values', () {
    expect(
      contrastRatio(const Color(0xFF000000), const Color(0xFFFFFFFF)),
      closeTo(21, 0.01),
    );
    expect(contrastRatio(AppColors.ink, AppColors.ink), closeTo(1, 0.01));
  });

  group('text pairs reach 4.5:1 (WCAG AA)', () {
    const pairs = {
      'ink on card': (AppColors.ink, AppColors.card),
      'ink on page': (AppColors.ink, AppColors.page),
      'ink on line (neutral button)': (AppColors.ink, AppColors.line),
      'ink on orange': (AppColors.ink, AppColors.orange),
      'ink on green tint': (AppColors.ink, AppColors.greenTint),
      'dark green on page': (AppColors.darkGreen, AppColors.page),
      'dark green on card': (AppColors.darkGreen, AppColors.card),
      'dark green on green tint': (AppColors.darkGreen, AppColors.greenTint),
      'graphite on page': (AppColors.graphite, AppColors.page),
      'white on ink (snack bar)': (AppColors.white, AppColors.ink),
    };
    for (final MapEntry(key: name, value: (fg, bg)) in pairs.entries) {
      test(
        name,
        () => expect(contrastRatio(fg, bg), greaterThanOrEqualTo(4.5)),
      );
    }
  });

  test('white on forest green reaches 3:1, so only for bold or large text', () {
    // 4.3:1 misses AA for body text; the primary button label is bold 18.
    final ratio = contrastRatio(AppColors.white, AppColors.forestGreen);
    expect(ratio, greaterThanOrEqualTo(3));
    expect(ratio, lessThan(4.5));
  });

  group('map and control shapes reach 3:1 (WCAG non-text)', () {
    const pairs = {
      'forest green button on card': (AppColors.forestGreen, AppColors.card),
      'olive field edge on page ground': (AppColors.olive, AppColors.page),
      'olive field edge on green tint ground': (
        AppColors.olive,
        AppColors.greenTint,
      ),
      'ink marker outline on page ground': (AppColors.ink, AppColors.page),
      'graphite outline on page': (AppColors.graphite, AppColors.page),
    };
    for (final MapEntry(key: name, value: (fg, bg)) in pairs.entries) {
      test(name, () => expect(contrastRatio(fg, bg), greaterThanOrEqualTo(3)));
    }
  });
}
