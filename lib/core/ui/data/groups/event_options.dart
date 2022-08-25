import 'package:tumble/core/ui/data/string_constant_group.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventOptionsStrings extends StringConstantGroup {
  EventOptionsStrings(AppLocalizations localizedStrings) : super(localizedStrings);

  String removeEventNotification() => localizedStrings.eventOptionsRemoveEventNotification;
  String removeCourseNotifications() => localizedStrings.eventOptionsRemoveCourseNotifications;
  String addEventNotification() => localizedStrings.eventOptionsAddEventNotification;
  String addCourseNotifications() => localizedStrings.eventOptionsAddCourseNotifications;
  String changeCourseColor() => localizedStrings.eventOptionsChangeCourseColor;
  String colorPickerTitle() => localizedStrings.eventOptionsColorPickerTitle;
}
