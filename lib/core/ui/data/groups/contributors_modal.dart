import 'package:tumble/core/ui/data/string_constant_group.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContributorsModalStrings extends StringConstantGroup {
  ContributorsModalStrings(AppLocalizations localizedStrings) : super(localizedStrings);

  String title() => localizedStrings.contributorsModalTitle;
  String development() => localizedStrings.contributorsModalDevelopment;
  String design() => localizedStrings.contributorsModalDesign;
  String translation() => localizedStrings.contributorsModalTranslation;
  String specialThanks() => localizedStrings.contributorsModalSpecialThanks;
}
