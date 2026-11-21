import 'package:flutter/material.dart';

import '../../../strings.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_theme.dart';

/// The agent's own position: a lake blue dot with a "You are here" pill
/// under it.
///
/// The dot sits in the exact center of [size], so the map marker can be
/// centered on the position.
class PositionMarker extends StatelessWidget {
  const PositionMarker({super.key});

  static const size = Size(180, 120);

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.lakeBlue.withValues(alpha: 0.25),
            ),
          ),
          // The thin ink edge keeps the dot at 3:1 on pale map tiles, where
          // lake blue alone falls short.
          Container(
            width: 27,
            height: 27,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.lakeBlue,
              border: Border.all(color: AppColors.white, width: 3),
            ),
            foregroundDecoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.ink,
                width: 1.5,
                strokeAlign: BorderSide.strokeAlignOutside,
              ),
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: MapLabelPill(text: AppStrings.youAreHere),
          ),
        ],
      ),
    );
  }
}

/// A white label pill on the map, shared by field names and the position
/// marker.
class MapLabelPill extends StatelessWidget {
  const MapLabelPill({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    // Labels must fit their marker box, so very large text scales down
    // instead of overflowing onto the map.
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.s8,
          vertical: AppSpacing.s4,
        ),
        decoration: ShapeDecoration(
          color: AppColors.card,
          shape: const StadiumBorder(),
          shadows: [
            BoxShadow(
              color: AppColors.ink.withValues(alpha: 0.2),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: AppColors.ink,
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
