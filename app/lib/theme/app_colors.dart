import 'package:flutter/painting.dart';

/// The Virunga mood board palette. Each color carries one meaning
/// everywhere, so pick by role, not by look.
///
/// Values come from the mood board swatches. Amber and the tints are
/// proposals until Virunga's brand owner confirms them.
abstract final class AppColors {
  // Palette.

  /// Voice: headlines, big numbers, selected states.
  static const darkGreen = Color(0xFF12582F);

  /// Action and done: the main button, finished, positive. White text on it
  /// only when bold or large (4.3:1).
  static const forestGreen = Color(0xFF008D36);

  /// Land: fields, nature and place elements.
  static const olive = Color(0xFF69893E);

  /// Progress bar fill only. Never for text.
  static const lime = Color(0xFFDEDC00);

  /// Under way or needs a look. Ink text on it, never white (2.8:1).
  static const orange = Color(0xFFEF7D00);

  /// Protected: restricted and security elements.
  static const navy = Color(0xFF1B2B48);

  /// Guidance: helpers, hints, the agent's own position.
  static const lakeBlue = Color(0xFF34A6BA);

  /// Money: budgets and funds.
  static const amber = Color(0xFFF8B800);

  // Neutrals and tints.

  static const page = Color(0xFFF3F4F0);
  static const card = Color(0xFFFFFFFF);
  static const ink = Color(0xFF1C1E1D);
  static const graphite = Color(0xFF54565E);

  /// Thin dividers, and the fill of the quiet second button.
  static const line = Color(0xFFDBDCD7);

  static const greenTint = Color(0xFFDFF1E4);
  static const amberTint = Color(0xFFFEF2CE);
  static const navyTint = Color(0xFFE1E6EC);

  static const white = Color(0xFFFFFFFF);
}
