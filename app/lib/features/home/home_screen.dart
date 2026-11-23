import 'package:flutter/material.dart';

import '../../strings.dart';
import '../map/map_screen.dart';
import '../registration/field_walk_screen.dart';
import '../registration/find_farmer_screen.dart';
import '../search/search_screen.dart';
import '../settings/settings_screen.dart';
import '../sync/send_to_office_screen.dart';



abstract final class _HomeColors {
  static const pageBackground = Color(0xFFF6F7F4);
  static const surface = Color(0xFFFFFFFF);
  static const darkGreenHeading = Color(0xFF163D29);
  static const forestGreen = Color(0xFF1E5631);
  static const softGreenTint = Color(0xFFE6F0EA);
  static const textPrimary = Color(0xFF1A1F1C);
  static const textSecondary = Color(0xFF3E4A43);
  static const border = Color(0xFFC2CEC6);
  static const pendingBackground = Color(0xFFFFF0D4);
  static const pendingForeground = Color(0xFF6B3A00);
}


class HomePendingItem {
  const HomePendingItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.destinationBuilder,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final WidgetBuilder destinationBuilder;
}

/// Summary shown at the top of Home: signed-in agent, active campaign,
/// connection state, pending files waiting to send, and unfinished work.
///
/// Uses synthetic placeholder values 

class HomeStatus {
  const HomeStatus({
    required this.agentName,
    required this.campaignName,
    required this.isOnline,
    required this.pendingCount,
    this.pendingItems = const [],
  });

  
  const HomeStatus.placeholder()
    : agentName = AppStrings.placeholderAgentName,
      campaignName = AppStrings.placeholderCampaignName,
      isOnline = false,
      pendingCount = 3,
      pendingItems = _placeholderPendingItems;

  static const _placeholderPendingItems = [
    HomePendingItem(
      title: AppStrings.placeholderPendingFarmerOne,
      subtitle: AppStrings.placeholderPendingStatusOne,
      icon: Icons.directions_walk_outlined,
      destinationBuilder: _buildFieldWalkScreen,
    ),
    HomePendingItem(
      title: AppStrings.placeholderPendingFarmerTwo,
      subtitle: AppStrings.placeholderPendingStatusTwo,
      icon: Icons.cloud_upload_outlined,
      destinationBuilder: _buildSendToOfficeScreen,
    ),
  ];

  static Widget _buildFieldWalkScreen(BuildContext context) =>
      const FieldWalkScreen();

  static Widget _buildSendToOfficeScreen(BuildContext context) =>
      const SendToOfficeScreen();

  final String agentName;
  final String campaignName;
  final bool isOnline;
  final int pendingCount;
  final List<HomePendingItem> pendingItems;
}

/// One action row on the Home screen.
///
/// To add a new action button to Home, add its label and subtitle to
/// [AppStrings] and append a [HomeAction] entry to [HomeScreen.buildActions].
class HomeAction {
  const HomeAction({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.destinationBuilder,
    this.badgeText,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final WidgetBuilder destinationBuilder;
  final String? badgeText;
}

/// Home tab: the agent's starting point after sign-in.
///
/// Displays the signed-in agent, active campaign, interactive connection and
/// pending-send status, the primary New farmer button, one list-tile action
/// per workflow, and pending work as flat list tiles (not cards). Language
/// selection lives in Settings , not at the top of this page.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, this.status = const HomeStatus.placeholder()});

  final HomeStatus status;

  /// Secondary workflow actions shown below the primary New farmer button.
  static List<HomeAction> buildActions(HomeStatus status) => [
    HomeAction(
      title: AppStrings.homeFindFarmerAction,
      subtitle: AppStrings.homeFindFarmerSubtitle,
      icon: Icons.person_search_outlined,
      destinationBuilder: (_) => const SearchScreen(),
    ),
    HomeAction(
      title: AppStrings.fieldWalkTitle,
      subtitle: AppStrings.homeFieldWalkSubtitle,
      icon: Icons.directions_walk_outlined,
      destinationBuilder: (_) => const FieldWalkScreen(),
    ),
    HomeAction(
      title: AppStrings.mapTitle,
      subtitle: AppStrings.homeMapSubtitle,
      icon: Icons.map_outlined,
      destinationBuilder: (_) => const MapScreen(),
    ),
    HomeAction(
      title: AppStrings.sendToOfficeTitle,
      subtitle: AppStrings.homeSendToOfficeSubtitle,
      icon: Icons.cloud_upload_outlined,
      destinationBuilder: (_) => const SendToOfficeScreen(),
      badgeText: status.pendingCount > 0 ? '${status.pendingCount}' : null,
    ),
    HomeAction(
      title: AppStrings.settingsTitle,
      subtitle: AppStrings.homeSettingsSubtitle,
      icon: Icons.settings_outlined,
      destinationBuilder: (_) => const SettingsScreen(),
    ),
  ];

  void _openRoute(BuildContext context, WidgetBuilder builder) {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: builder));
  }

  void _showConnectionInfo(BuildContext context) {
    final message = status.isOnline
        ? AppStrings.statusOnlineMessage
        : AppStrings.statusOfflineMessage;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
      );
  }

  @override
  Widget build(BuildContext context) {
    final actions = buildActions(status);
    return Scaffold(
      backgroundColor: _HomeColors.pageBackground,
      appBar: AppBar(
        backgroundColor: _HomeColors.pageBackground,
        foregroundColor: _HomeColors.darkGreenHeading,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          AppStrings.homeTitle,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: _HomeColors.darkGreenHeading,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: AppStrings.settingsTitle,
            onPressed: () => _openRoute(context, (_) => const SettingsScreen()),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
        children: [
          _HomeStatusHeader(
            status: status,
            onConnectionTap: () => _showConnectionInfo(context),
            onPendingTap: () =>
                _openRoute(context, (_) => const SendToOfficeScreen()),
          ),
          const SizedBox(height: 14),
          FilledButton.icon(
            icon: const Icon(Icons.person_add_outlined, size: 24),
            label: const Text(AppStrings.newFarmer),
            style: FilledButton.styleFrom(
              backgroundColor: _HomeColors.forestGreen,
              foregroundColor: Colors.white,
              minimumSize: const Size.fromHeight(60),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            onPressed: () =>
                _openRoute(context, (_) => const FindFarmerScreen()),
          ),
          const SizedBox(height: 18),
          const _SectionHeading(AppStrings.homeActionsHeading),
          const SizedBox(height: 8),
          _BorderedTileList(
            children: [
              for (final action in actions)
                _HomeActionTile(
                  action: action,
                  onTap: () => _openRoute(context, action.destinationBuilder),
                ),
            ],
          ),
          const SizedBox(height: 18),
          const _SectionHeading(AppStrings.homePendingHeading),
          const SizedBox(height: 8),
          if (status.pendingItems.isEmpty)
            const _BorderedTileList(
              children: [
                ListTile(
                  minTileHeight: 56,
                  leading: Icon(
                    Icons.check_circle_outline,
                    color: _HomeColors.darkGreenHeading,
                  ),
                  title: Text(
                    AppStrings.homePendingEmpty,
                    style: TextStyle(
                      fontSize: 15,
                      color: _HomeColors.textSecondary,
                    ),
                  ),
                ),
              ],
            )
          else
            _BorderedTileList(
              children: [
                for (final item in status.pendingItems)
                  _PendingWorkTile(
                    item: item,
                    onTap: () => _openRoute(context, item.destinationBuilder),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: _HomeColors.darkGreenHeading,
      ),
    );
  }
}

class _BorderedTileList extends StatelessWidget {
  const _BorderedTileList({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _HomeColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: _HomeColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          for (var i = 0; i < children.length; i++) ...[
            if (i > 0) const Divider(height: 1, color: _HomeColors.border),
            children[i],
          ],
        ],
      ),
    );
  }
}

class _HomeStatusHeader extends StatelessWidget {
  const _HomeStatusHeader({
    required this.status,
    required this.onConnectionTap,
    required this.onPendingTap,
  });

  final HomeStatus status;
  final VoidCallback onConnectionTap;
  final VoidCallback onPendingTap;

  @override
  Widget build(BuildContext context) {
    final hasPending = status.pendingCount > 0;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _HomeColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _HomeColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 10,
            runSpacing: 4,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.person_outline,
                    size: 20,
                    color: _HomeColors.darkGreenHeading,
                  ),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      status.agentName,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: _HomeColors.darkGreenHeading,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                status.campaignName,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: _HomeColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _StatusButton(
                icon: status.isOnline
                    ? Icons.wifi_outlined
                    : Icons.wifi_off_outlined,
                label: status.isOnline
                    ? AppStrings.statusOnline
                    : AppStrings.statusOffline,
                backgroundColor: status.isOnline
                    ? _HomeColors.softGreenTint
                    : _HomeColors.pendingBackground,
                foregroundColor: status.isOnline
                    ? _HomeColors.darkGreenHeading
                    : _HomeColors.pendingForeground,
                onTap: onConnectionTap,
              ),
              _StatusButton(
                icon: hasPending
                    ? Icons.schedule_outlined
                    : Icons.check_circle_outline,
                label: AppStrings.filesWaitingToSend(status.pendingCount),
                backgroundColor: hasPending
                    ? _HomeColors.pendingBackground
                    : _HomeColors.softGreenTint,
                foregroundColor: hasPending
                    ? _HomeColors.pendingForeground
                    : _HomeColors.darkGreenHeading,
                onTap: onPendingTap,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusButton extends StatelessWidget {
  const _StatusButton({
    required this.icon,
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color backgroundColor;
  final Color foregroundColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48, minWidth: 48),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 18, color: foregroundColor),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: foregroundColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HomeActionTile extends StatelessWidget {
  const _HomeActionTile({required this.action, required this.onTap});

  final HomeAction action;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final badgeText = action.badgeText;
    return ListTile(
      minTileHeight: 64,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: _HomeColors.softGreenTint,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(action.icon, size: 24, color: _HomeColors.darkGreenHeading),
      ),
      title: Text(
        action.title,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: _HomeColors.textPrimary,
        ),
      ),
      subtitle: Text(
        action.subtitle,
        style: const TextStyle(fontSize: 14, color: _HomeColors.textSecondary),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (badgeText != null) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: _HomeColors.pendingBackground,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                badgeText,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: _HomeColors.pendingForeground,
                ),
              ),
            ),
            const SizedBox(width: 6),
          ],
          const Icon(Icons.chevron_right, color: _HomeColors.darkGreenHeading),
        ],
      ),
      onTap: onTap,
    );
  }
}

class _PendingWorkTile extends StatelessWidget {
  const _PendingWorkTile({required this.item, required this.onTap});

  final HomePendingItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minTileHeight: 64,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: _HomeColors.pendingBackground,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(item.icon, size: 22, color: _HomeColors.pendingForeground),
      ),
      title: Text(
        item.title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: _HomeColors.textPrimary,
        ),
      ),
      subtitle: Text(
        item.subtitle,
        style: const TextStyle(fontSize: 14, color: _HomeColors.textSecondary),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: _HomeColors.darkGreenHeading,
      ),
      onTap: onTap,
    );
  }
}
