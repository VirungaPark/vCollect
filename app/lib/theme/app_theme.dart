import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Spacing on the mood board's grid of 8.
abstract final class AppSpacing {
  static const s4 = 4.0;
  static const s8 = 8.0;
  static const s12 = 12.0;
  static const s16 = 16.0;
  static const s24 = 24.0;

  static const pageMargin = s16;
}

abstract final class AppRadii {
  /// Buttons.
  static const button = 12.0;

  /// Cards and sheets.
  static const card = 16.0;
}

/// The two button looks the app allows (Target Design §7.2: one colored
/// button per screen, the others neutral).
abstract final class AppButtonStyles {
  /// The one colored action. Bold 18 keeps white on forest green readable,
  /// since the pair only passes contrast for large or bold text.
  static final primary = FilledButton.styleFrom(
    backgroundColor: AppColors.forestGreen,
    foregroundColor: AppColors.white,
    minimumSize: const Size(64, 56),
    iconSize: 24,
    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadii.button),
    ),
  );

  /// Quiet grey second choice. No border, per the mood board.
  static final neutral = FilledButton.styleFrom(
    backgroundColor: AppColors.line,
    foregroundColor: AppColors.ink,
    minimumSize: const Size(64, 48),
    iconSize: 22,
    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadii.button),
    ),
  );
}

/// The app's single theme. A first slice of Issue #8: only what the
/// screens built so far need.
abstract final class AppTheme {
  static final light = ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.forestGreen,
      onPrimary: AppColors.white,
      primaryContainer: AppColors.greenTint,
      onPrimaryContainer: AppColors.darkGreen,
      secondary: AppColors.darkGreen,
      onSecondary: AppColors.white,
      secondaryContainer: AppColors.greenTint,
      onSecondaryContainer: AppColors.darkGreen,
      tertiary: AppColors.lakeBlue,
      onTertiary: AppColors.ink,
      // The palette has no red; orange is its "needs a look" color.
      error: AppColors.orange,
      onError: AppColors.ink,
      surface: AppColors.card,
      onSurface: AppColors.ink,
      onSurfaceVariant: AppColors.graphite,
      // Graphite keeps outlined controls at 3:1; line is for dividers only.
      outline: AppColors.graphite,
      outlineVariant: AppColors.line,
    ),
    scaffoldBackgroundColor: AppColors.page,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.page,
      foregroundColor: AppColors.darkGreen,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyle(
        color: AppColors.darkGreen,
        fontSize: 22,
        fontWeight: FontWeight.w700,
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(style: AppButtonStyles.primary),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: AppColors.ink,
      contentTextStyle: TextStyle(color: AppColors.white, fontSize: 16),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        color: AppColors.darkGreen,
        fontSize: 22,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: TextStyle(
        color: AppColors.darkGreen,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
      titleSmall: TextStyle(
        color: AppColors.darkGreen,
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
    ),
    listTileTheme: const ListTileThemeData(
      iconColor: AppColors.darkGreen,
      textColor: AppColors.ink,
      titleTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.ink
      ),
      subtitleTextStyle: TextStyle(
        fontSize: 14,
        color: AppColors.graphite,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: AppSpacing.pageMargin),
    ),
    dividerTheme: const DividerThemeData(
      color: AppColors.line,
      thickness: 1,
      space: 1,
    )
  );
}
