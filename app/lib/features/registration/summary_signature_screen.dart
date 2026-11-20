import 'package:flutter/material.dart';

import '../../widgets/placeholder_body.dart';
import 'registration_step.dart';

/// Registration step 4 (last): review the file and capture the farmer's
/// signature.
///
/// Step names are shown as tooltips on the step indicator, only on request.
class SummarySignatureScreen extends StatelessWidget {
  const SummarySignatureScreen({super.key});

  static const step = RegistrationStep.summarySignature;

  @override
  Widget build(BuildContext context) {
    return RegistrationStepScaffold(
      step: step,
      body: PlaceholderBody(title: step.title, description: step.description),
    );
  }
}
