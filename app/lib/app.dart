import 'package:flutter/material.dart';

import 'strings.dart';
import 'widgets/placeholder_body.dart';

class VCollectApp extends StatelessWidget {
  const VCollectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appTitle,
      home: Scaffold(
        appBar: AppBar(title: const Text(AppStrings.homeTitle)),
        body: const PlaceholderBody(
          title: AppStrings.homeTitle,
          description: AppStrings.homeDescription,
        ),
      ),
    );
  }
}
