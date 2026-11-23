/// Every user-facing string in the app, kept in one place.
///
/// English only for now.
/// TODO(#9): Move these keys into English, French, and Swahili localization
/// files once issue #9 merges.
abstract final class AppStrings {
  static const appTitle = 'vCollect';

  // Bottom navigation tabs.
  static const homeTitle = 'Home';

  // Home status placeholders (synthetic data only).
  // TODO(#10): Replace with signed-in agent and active campaign from session.
  static const placeholderAgentName = 'Amara N.';
  static const placeholderCampaignName = 'North Zone 2026';
  static const statusOnline = 'Online';
  static const statusOffline = 'Offline';
  static const statusOnlineMessage =
      'Connected. Saved files are ready to send to the office.';
  static const statusOfflineMessage =
      'Working offline. Your work stays saved on this phone.';

  /// Plain-language count of saved files waiting to be sent to the office.
  static String filesWaitingToSend(int count) {
    if (count == 0) {
      return 'All files sent';
    }
    if (count == 1) {
      return '1 file to send';
    }
    return '$count files to send';
  }

  // Home actions.
  static const homeActionsHeading = 'Actions';
  static const homeFindFarmerAction = 'Find farmer';
  static const homeFindFarmerSubtitle = 'Look up a saved farmer';
  static const homeFieldWalkSubtitle = 'Walk and mark a field edge';
  static const homeMapSubtitle = 'View saved fields offline';
  static const homeSendToOfficeSubtitle = 'Review and send saved files';
  static const homeSettingsSubtitle = 'Language and app choices';

  // Home pending work placeholders (synthetic data only).
  static const homePendingHeading = 'Unfinished work';
  static const homePendingEmpty = 'No unfinished work right now.';
  static const placeholderPendingFarmerOne = 'Marie T.';
  static const placeholderPendingStatusOne = 'Field walk not finished';
  static const placeholderPendingFarmerTwo = 'Kofi M.';
  static const placeholderPendingStatusTwo = 'Ready to send to office';

  static const searchTitle = 'Search';
  static const searchDescription = 'Find a farmer by card or name, offline.';

  static const mapTitle = 'Map';
  static const mapDescription = 'Offline map of fields and boundaries.';

  static const sendToOfficeTitle = 'Send to office';

  /// Short bottom-nav label, so it stays on one line at large text sizes.
  static const sendTabLabel = 'Send';
  static const sendToOfficeDescription = 'Files ready to send and sync status.';

  // Screens opened from a tab.
  static const settingsTitle = 'Settings';
  static const settingsDescription = 'Language and app settings.';
  static const settingsLanguage = 'Language';

  static const farmerFileTitle = 'Farmer file';
  static const farmerFileDescription = "One farmer's details and fields.";
  static const openFarmerFile = 'Open a farmer file';

  // Registration flow.
  static const newFarmer = 'New farmer';
  static const next = 'Next';
  static const done = 'Done';

  static const findFarmerTitle = 'Find the farmer';
  static const findFarmerDescription =
      'Scan the Virunga card or type a name. Cache and zone info go on the '
      'backdrop only.';

  static const idCardTitle = 'ID card';
  static const idCardDescription = "Photograph the farmer's ID card.";

  static const fieldWalkTitle = 'Field walk';
  static const fieldWalkDescription =
      'Walk the field edge and place a flag at each corner.';

  static const summarySignatureTitle = 'Summary & signature';
  static const summarySignatureDescription =
      'Review the file and have the farmer sign.';

  /// App bar title for a registration step.
  static String stepOf(int step, int total) => 'Step $step of $total';
}
