import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'signal_level.dart';

/// Signal bars and words in a pill, for the top of a screen (Target
/// Design §12.1 puts them on every screen).
class GpsSignalIndicator extends StatelessWidget {
  const GpsSignalIndicator({super.key, required this.level});

  final SignalLevel level;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s12,
        vertical: AppSpacing.s4,
      ),
      decoration: ShapeDecoration(
        color: level.background,
        shape: const StadiumBorder(),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // The label already says it, so screen readers skip the bars.
          ExcludeSemantics(
            child: Icon(level.icon, size: 18, color: level.iconColor),
          ),
          const SizedBox(width: AppSpacing.s4),
          Text(
            level.label,
            style: TextStyle(
              color: level.foreground,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
