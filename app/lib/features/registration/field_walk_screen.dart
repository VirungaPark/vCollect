import 'package:flutter/material.dart';

import '../../widgets/placeholder_body.dart';
import 'registration_step.dart';
import 'summary_signature_screen.dart';

/// Registration step 3: walk the field boundary.
///
/// To build: the map with the walked line, Place a flag, Undo and Pause.
/// Step names are shown as tooltips on the step indicator, only on request.
class FieldWalkScreen extends StatelessWidget {
  const FieldWalkScreen({super.key});

  static const step = RegistrationStep.fieldWalk;

  @override
  Widget build(BuildContext context) {
    return RegistrationStepScaffold(
      step: step,
      nextScreen: (_) => const SummarySignatureScreen(),
      body: PlaceholderBody(title: step.title, description: step.description),
    );
  }
}
