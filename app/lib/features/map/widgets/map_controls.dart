import 'package:flutter/material.dart';

import '../../../strings.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_theme.dart';

/// The sheet under the map: two quiet buttons above the one colored
/// action, which sits under the thumb (Target Design §7.2, rule 4).
class MapControls extends StatelessWidget {
  const MapControls({
    super.key,
    required this.onMyPosition,
    required this.onLayers,
    required this.onGoTo,
  });

  final VoidCallback onMyPosition;
  final VoidCallback onLayers;
  final VoidCallback onGoTo;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppRadii.card),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.ink.withValues(alpha: 0.15),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.s16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    style: AppButtonStyles.neutral,
                    icon: const Icon(Icons.layers_outlined),
                    label: const Text(AppStrings.layers),
                    onPressed: onLayers,
                  ),
                ),
                const SizedBox(width: AppSpacing.s12),
                Expanded(
                  child: FilledButton.icon(
                    style: AppButtonStyles.neutral,
                    icon: const Icon(Icons.near_me_outlined),
                    label: const Text(AppStrings.goTo),
                    onPressed: onGoTo,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.s12),
            FilledButton.icon(
              style: AppButtonStyles.primary,
              icon: const Icon(Icons.my_location),
              label: const Text(AppStrings.myPosition),
              onPressed: onMyPosition,
            ),
          ],
        ),
      ),
    );
  }
}
