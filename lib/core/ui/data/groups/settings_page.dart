import 'package:tumble/core/ui/data/string_constant_group.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPageStrings extends StringConstantGroup {
  SettingsPageStrings(AppLocalizations localizedStrings) : super(localizedStrings);

  String title() => localizedStrings.settingsTitle;
  String supportTitle() => localizedStrings.settingsSupportTitle;
  String contactTitle() => localizedStrings.settingsSupportContactTitle;
  String contactSubtitle() => localizedStrings.settingsSupportContactSubtitle;
  String commonTitle() => localizedStrings.settingsCommonTitle;
  String changeSchoolTitle() => localizedStrings.settingsCommonChangeSchoolsTitle;
  String changeSchoolSubtitle(String schoolAbbreviation) =>
      localizedStrings.settingsCommonChangeSchoolsSubtitle(schoolAbbreviation);
  String changeThemeTitle() => localizedStrings.settingsCommonChangeThemeTitle;
  String changeThemeSubtitle(String themeName) => localizedStrings.settingsCommonChangeThemeSubtitle(themeName);
  String scheduleTitle() => localizedStrings.settingsScheduleTitle;
  String defaultScheduleTitle() => localizedStrings.settingsScheduleDefaultScheduleTitle;
  String defaultScheduleEmptySubtitle() => localizedStrings.settingsScheduleDefaultScheduleSubtitleNoneSelected;
  String defaultScheduleSubtitle(String scheduleId) =>
      localizedStrings.settingsScheduleDefaultScheduleSubtitle(scheduleId);
  String notificationTitle() => localizedStrings.settingsNotificationTitle;
  String clearAllTitle() => localizedStrings.settingsNotificationClearAllTitle;
  String clearAllSubtitle() => localizedStrings.settingsNotificationClearAllSubtitle;
  String offsetTitle() => localizedStrings.settingsNotificationOffsetTitle;
  String offsetSubtitle(String notificationOffset) =>
      localizedStrings.settingNotificationOffsetSubtitle(notificationOffset);
}
