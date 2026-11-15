import 'package:flutter/material.dart';

import '../../widgets/placeholder_body.dart';
import 'field_walk_screen.dart';
import 'registration_step.dart';

/// Registration step 2: photograph the farmer's ID card.
class IdCardScreen extends StatelessWidget {
  const IdCardScreen({super.key});

  static const step = RegistrationStep.idCard;

  @override
  Widget build(BuildContext context) {
    return RegistrationStepScaffold(
      step: step,
      nextScreen: (_) => const FieldWalkScreen(),
      body: PlaceholderBody(title: step.title, description: step.description),
    );
  }
}
