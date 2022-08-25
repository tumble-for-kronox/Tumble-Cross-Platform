import 'package:flutter/cupertino.dart';
import 'package:tumble/core/ui/data/string_constant_group.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WeekViewPageStrings extends StringConstantGroup {
  WeekViewPageStrings(AppLocalizations localizedStrings) : super(localizedStrings);

  String title() => localizedStrings.weekViewTitle;
  String weekNumber(String weekNumber) => localizedStrings.weekViewNumber(weekNumber);
  String todayLabel() => localizedStrings.weekViewTodayLabel;
  String noActivities() => localizedStrings.weekViewNoActivities;
}
