import 'package:tumble/core/ui/data/string_constant_group.dart';

class SettingsPageStrings extends StringConstantGroup {
  SettingsPageStrings(super.localizedStrings);

  String title() => localizedStrings.settingsTitle;

  String commonTitle() => localizedStrings.settingsCommonTitle;
  String changeSchoolTitle() => localizedStrings.settingsCommonChangeSchoolsTitle;
  String changeSchoolSubtitle(String schoolAbbreviation) =>
      localizedStrings.settingsCommonChangeSchoolsSubtitle(schoolAbbreviation);
  String chooseUniversity() => localizedStrings.settingsChooseUniversity;
  String changeThemeTitle() => localizedStrings.settingsCommonChangeThemeTitle;
  String changeThemeSubtitle(String themeName) => localizedStrings.settingsCommonChangeThemeSubtitle(themeName);

  String scheduleTitle() => localizedStrings.settingsScheduleTitle;
  String defaultScheduleTitle() => localizedStrings.settingsScheduleDefaultScheduleTitle;
  String defaultScheduleSubtitle() => localizedStrings.settingsScheduleDefaultScheduleSubtitle;
  String bookmarksEmpty() => localizedStrings.settingsScheduleNoBookmarks;

  String notificationTitle() => localizedStrings.settingsNotificationTitle;
  String clearAllTitle() => localizedStrings.settingsNotificationClearAllTitle;
  String clearAllSubtitle() => localizedStrings.settingsNotificationClearAllSubtitle;
  String offsetTitle() => localizedStrings.settingsNotificationOffsetTitle;
  String offsetSubtitle(int notificationOffset) =>
      localizedStrings.settingNotificationOffsetSubtitle + offsetTime(notificationOffset);
  String offsetTime(int minutes) {
    if (minutes < 60) {
      return localizedStrings.settingsNotificationOffsetMinutes(minutes);
    }

    return localizedStrings.settingsNotificationOffsetHours(minutes ~/ 60);
  }

  String miscTitle() => localizedStrings.settingsMiscTitle;
  String reportBugTitle() => localizedStrings.settingsMiscBugTitle;
  String reportBugSubtitle() => localizedStrings.settingsMiscBugSubtitle;
  String rateTitle() => localizedStrings.settingsMiscRateTitle;
  String rateSubtitle(String storeName) => localizedStrings.settingsMiscRateSubtitle(storeName);
  String languageTitle() => localizedStrings.settingsMiscChangeLanguageTitle;
  String languageSubtitle() => localizedStrings.settingsMiscChangeLanguageSubtitle;
  String contributorsTitle() => localizedStrings.settingsMiscContributorsTitle;
  String contributorsSubtitle() => localizedStrings.settingsMiscCotributorsSubtitle;
}
