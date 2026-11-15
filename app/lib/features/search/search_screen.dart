import 'package:flutter/material.dart';

import '../../strings.dart';
import '../../widgets/placeholder_body.dart';
import 'farmer_file_screen.dart';

/// Search tab: find a farmer already known on the phone.
///
/// To build: search by Virunga card or name, fully offline. The placeholder
/// button stands in for tapping a search result.
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.searchTitle)),
      body: PlaceholderBody(
        title: AppStrings.searchTitle,
        description: AppStrings.searchDescription,
        action: FilledButton(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute<void>(builder: (_) => const FarmerFileScreen()),
          ),
          child: const Text(AppStrings.openFarmerFile),
        ),
      ),
    );
  }
}
