import 'package:flutter/material.dart';

import '../strings.dart';
import '../theme/app_colors.dart';

/// How good the position signal is, as the agent sees it (Target Design
/// §12.1): words and bars, never metres.
///
/// No thresholds live here. The administrator sets them per question
/// (§12.2), so mapping a measurement to a level belongs with that setting.
enum SignalLevel {
  good(
    label: AppStrings.gpsSignalGood,
    icon: Icons.signal_cellular_alt,
    background: AppColors.greenTint,
    foreground: AppColors.darkGreen,
    iconColor: AppColors.forestGreen,
  ),

  // The palette has no red, so both weak levels use the "needs a look"
  // orange. The words and bar count tell them apart.
  close(
    label: AppStrings.gpsSignalWeak,
    icon: Icons.signal_cellular_alt_2_bar,
    background: AppColors.orange,
    foreground: AppColors.ink,
    iconColor: AppColors.ink,
  ),
  weak(
    label: AppStrings.gpsSignalTooWeak,
    icon: Icons.signal_cellular_alt_1_bar,
    background: AppColors.orange,
    foreground: AppColors.ink,
    iconColor: AppColors.ink,
  );

  const SignalLevel({
    required this.label,
    required this.icon,
    required this.background,
    required this.foreground,
    required this.iconColor,
  });

  final String label;
  final IconData icon;
  final Color background;
  final Color foreground;
  final Color iconColor;
}
