import 'package:flutter/material.dart';

import '../../strings.dart';
import '../../widgets/placeholder_body.dart';

/// Send to office tab.
///
/// To build: the files ready to send, their sync status and the Send action.
class SendToOfficeScreen extends StatelessWidget {
  const SendToOfficeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.sendToOfficeTitle)),
      body: const PlaceholderBody(
        title: AppStrings.sendToOfficeTitle,
        description: AppStrings.sendToOfficeDescription,
      ),
    );
  }
}
