import 'package:flutter/material.dart';

import '../../strings.dart';

class LanguagesScreen extends StatefulWidget {
  final String currentLanguage;
  const LanguagesScreen({super.key, required this.currentLanguage});

  @override
  State<LanguagesScreen> createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends State<LanguagesScreen> {
  final List<String> _languages = AppStrings.languages;
  String currentLanguage =
      AppStrings.languages[0]; // todo: pull from phone prefs
  late String _selectedLanguage;

  @override
  void initState() {
    super.initState();
    _selectedLanguage = widget.currentLanguage;
  }

  void _selectLanguage(String language) {
    setState(() {
      _selectedLanguage = language;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.settingsLanguage),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(_selectedLanguage),
          tooltip: AppStrings.toolTipBack,
        ),
      ),
      body: ListView.builder(
        itemCount: _languages.length,
        itemBuilder: (BuildContext context, int index) {
          final language = _languages[index];
          final isSelected = language == _selectedLanguage;
          return ListTile(
            title: Text(_languages[index]),
            trailing: isSelected
                ? Icon(Icons.radio_button_checked)
                : Icon(Icons.radio_button_off),
            onTap: () => _selectLanguage(language),
          );
        },
      ),
    );
  }
}
