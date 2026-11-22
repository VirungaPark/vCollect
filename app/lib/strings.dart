/// Every user-facing string in the app, kept in one place.
///
/// English only for now. Issue #8 picks the localization mechanism; until
/// then, keeping the text here makes moving it into translation files a
/// mechanical change.
abstract final class AppStrings {
  static const appTitle = 'vCollect';

  // Bottom navigation tabs.
  static const homeTitle = 'Home';
  static const homeDescription =
      'Start here: pending work as list tiles, quick links, and the New '
      'farmer button.';

  static const searchTitle = 'Search';
  static const searchDescription = 'Find a farmer by card or name, offline.';

  static const mapTitle = 'Map';

  // Position signal (Target Design §12.1): words, never metres.
  static const gpsSignalGood = 'GPS signal good';
  static const gpsSignalWeak = 'GPS signal weak';
  static const gpsSignalTooWeak = 'GPS signal too weak';

  // Map screen.
  static const myPosition = 'My position';
  static const layers = 'Layers';
  static const goTo = 'Go to';
  static const zoomIn = 'Zoom in';
  static const zoomOut = 'Zoom out';
  static const youAreHere = 'You are here';
  static const lookingForPosition = 'Looking for your position…';
  static const notReadyYet = 'This is not ready yet.';
  static const locationOff = 'Turn on location to see where you are.';
  static const turnOnLocation = 'Turn on location';

  /// Map label for a field, for example "Field 1 (Cocoa)".
  static String fieldLabel(String name, String? crop) =>
      crop == null ? name : '$name ($crop)';

  static const sendToOfficeTitle = 'Send to office';

  /// Short bottom-nav label, so it stays on one line at large text sizes.
  static const sendTabLabel = 'Send';
  static const sendToOfficeDescription = 'Files ready to send and sync status.';

  // Settings Screen
  static const settingsTitle = 'Settings';
  static const settingsDescription = 'Language and app settings.';

  // General section
  static const settingsGeneral = 'General';
  static const settingsLanguage = 'Language';
  static const settingsLanguageDescription = 'Change the language';
  static const settingsNotifications = 'Enable Notifications';
  static const settingsNotificationsDescription = 'Receive notifications from vCollect';
  static const settingsLocation = 'Enable Location Tracking';
  static const settingsLocationDescription = 'Turn on location';
  static const settingsEnableCellular = 'Enable cellular';
  static const settingsEnableCellularDescription = 'Enable cellular data use for campaign data transfer';

  // Storage section
  static const settingsStorage = 'Storage';
  static const settingsStorageSpace = 'Space remaining';
  static const settingsClearCache = 'Clear cache';
  static const settingsClearCacheDescription = 'Delete cached files';
  static const settingsCampaignPackages = 'Campaign packages';
  static const settingsViewCampaignPackages = 'View downloaded campaign packages';

  // Account section
  static const settingsAccount = 'Account';
  static const settingsPassword = 'Password';
  static const settingsPasswordDescription = 'Change your password';
  static const settingsEmail = 'Email';
  static const settingsEmailDescription = 'Change your email';
  static const settingsLogout = 'Logout';
  static const settingsLogoutDescription = 'Log out of vCollect';

  // Misc. Section
  static const settingsMisc = 'Misc.';
  static const settingsTerms = 'Terms';
  static const settingsTermsDescription = 'View terms and conditions';
  static const settingsLicenses = 'Licenses';
  static const settingsLicensesDescription = 'View open source licenses';
  static const settingsAbout = 'About';
  static const settingsAboutDescription = 'About vCollect';
  static const settingsReportBug = 'Report a bug';
  static const settingsReportBugDescription = 'Report a bug or feature request';

  // Language subscreen
  static const languages = ['English', 'French', 'Swahili'];

  // Screens opened from a tab.
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

  /// App bar title for a registration step, for example "Step 2 of 4".
  static String stepOf(int step, int total) => 'Step $step of $total';
}
