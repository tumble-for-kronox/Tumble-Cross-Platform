import 'package:tumble/core/ui/data/string_constant_group.dart';

class WeekViewPageStrings extends StringConstantGroup {
  WeekViewPageStrings(super.localizedStrings);

  String title() => localizedStrings.weekViewTitle;
  String weekNumber(String weekNumber) => localizedStrings.weekViewNumber(weekNumber);
  String todayLabel() => localizedStrings.weekViewTodayLabel;
  String noActivities() => localizedStrings.weekViewNoActivities;
}
