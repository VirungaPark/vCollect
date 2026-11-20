import 'package:flutter/material.dart';

import '../../strings.dart';
import '../../widgets/placeholder_body.dart';

/// Map tab.
///
/// To build: offline map of fields and boundaries (flutter_map + MBTiles).
class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.mapTitle)),
      body: const PlaceholderBody(
        title: AppStrings.mapTitle,
        description: AppStrings.mapDescription,
      ),
    );
  }
}
