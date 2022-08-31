import 'package:tumble/core/ui/data/string_constant_group.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DetailsModalStrings extends StringConstantGroup {
  DetailsModalStrings(AppLocalizations localizedStrings) : super(localizedStrings);

  String title() => localizedStrings.detailsTitle;
  String date() => localizedStrings.detailsDate;
  String time() => localizedStrings.detailsTime;
  String registerBefore() => localizedStrings.detailsRegisterBefore;
  String type() => localizedStrings.detailsType;
  String support() => localizedStrings.detailsSupport;
  String supportAvailable() => localizedStrings.detailsSupportAvailable;
  String supportUnavailable() => localizedStrings.detailsSupportUnavailable;
  String anonymousCode() => localizedStrings.detailsAnonymousCode;
  String registrationOpens() => localizedStrings.detailsRegistrationOpens;
  String location() => localizedStrings.detailsLocation;
  String course() => localizedStrings.detailsCourse;
  String teachers() => localizedStrings.detailsTeachers;
}
