import 'package:flutter/material.dart';

import '../../widgets/placeholder_body.dart';
import 'id_card_screen.dart';
import 'registration_step.dart';

/// Registration step 1: find the farmer.
///
/// To build: scan the Virunga card or type a name, or start a new profile.
/// Partner feedback: do not show the local cache count or the zone label on
/// this screen. If they are needed, put them on the backdrop.
class FindFarmerScreen extends StatelessWidget {
  const FindFarmerScreen({super.key});

  static const step = RegistrationStep.findFarmer;

  @override
  Widget build(BuildContext context) {
    return RegistrationStepScaffold(
      step: step,
      nextScreen: (_) => const IdCardScreen(),
      body: PlaceholderBody(title: step.title, description: step.description),
    );
  }
}
