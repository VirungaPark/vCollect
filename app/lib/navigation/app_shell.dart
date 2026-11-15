import 'package:flutter/material.dart';

import '../features/home/home_screen.dart';
import '../features/map/map_screen.dart';
import '../features/search/search_screen.dart';
import '../features/sync/send_to_office_screen.dart';
import '../strings.dart';

/// The app's top level: the four main tabs and the bottom navigation bar.
///
/// Tabs live in an [IndexedStack] so each keeps its state (scroll position,
/// map view, and so on) when the agent switches away and back. Screens
/// pushed from a tab, such as Settings or the registration flow, cover the
/// whole shell, so the bottom navigation bar is hidden while they are open.
class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;

  static const _tabs = <Widget>[
    HomeScreen(),
    SearchScreen(),
    MapScreen(),
    SendToOfficeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _tabs),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) =>
            setState(() => _selectedIndex = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: AppStrings.homeTitle,
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            label: AppStrings.searchTitle,
          ),
          NavigationDestination(
            icon: Icon(Icons.map_outlined),
            selectedIcon: Icon(Icons.map),
            label: AppStrings.mapTitle,
          ),
          NavigationDestination(
            icon: Icon(Icons.cloud_upload_outlined),
            selectedIcon: Icon(Icons.cloud_upload),
            label: AppStrings.sendToOfficeTitle,
          ),
        ],
      ),
    );
  }
}
