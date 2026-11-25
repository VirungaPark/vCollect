import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class SettingsSection extends StatefulWidget {
  const SettingsSection({
    super.key,
    required this.title,
    required this.children,
  });
  final String title;
  final List<Widget> children;
  @override
  State<SettingsSection> createState() => _SettingsSectionState();
}

class _SettingsSectionState extends State<SettingsSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.pageMargin,
            vertical: AppSpacing.s12,
          ),
          child: Text(
            widget.title,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        ...widget.children,
        const Divider(),
      ],
    );
  }
}
