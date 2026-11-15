import 'package:flutter/material.dart';

import '../../strings.dart';
import '../../widgets/placeholder_body.dart';

/// One farmer's file, opened from a search result.
///
/// To build: the farmer's details and each of their fields (FR-5).
class FarmerFileScreen extends StatelessWidget {
  const FarmerFileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.farmerFileTitle)),
      body: const PlaceholderBody(
        title: AppStrings.farmerFileTitle,
        description: AppStrings.farmerFileDescription,
      ),
    );
  }
}
