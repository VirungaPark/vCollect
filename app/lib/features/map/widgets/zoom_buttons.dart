import 'package:flutter/material.dart';

import '../../../strings.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_theme.dart';

/// Round + and − buttons, so zooming never needs a two-finger pinch
/// (NFR-6).
class ZoomButtons extends StatelessWidget {
  const ZoomButtons({
    super.key,
    required this.onZoomIn,
    required this.onZoomOut,
  });

  final VoidCallback onZoomIn;
  final VoidCallback onZoomOut;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _RoundMapButton(
          icon: Icons.add,
          tooltip: AppStrings.zoomIn,
          onPressed: onZoomIn,
        ),
        const SizedBox(height: AppSpacing.s8),
        _RoundMapButton(
          icon: Icons.remove,
          tooltip: AppStrings.zoomOut,
          onPressed: onZoomOut,
        ),
      ],
    );
  }
}

class _RoundMapButton extends StatelessWidget {
  const _RoundMapButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    // Shadow, no border: the mood board never uses both.
    return Material(
      color: AppColors.card,
      shape: const CircleBorder(),
      elevation: 3,
      shadowColor: AppColors.ink,
      child: IconButton(
        icon: Icon(icon),
        tooltip: tooltip,
        color: AppColors.ink,
        iconSize: 26,
        constraints: const BoxConstraints.tightFor(width: 52, height: 52),
        onPressed: onPressed,
      ),
    );
  }
}
