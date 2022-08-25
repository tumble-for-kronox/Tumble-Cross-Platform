import 'package:tumble/core/ui/data/string_constant_group.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GeneralStrings extends StringConstantGroup {
  GeneralStrings(AppLocalizations localizedStrings) : super(localizedStrings);

  String no() => localizedStrings.no;
  String yes() => localizedStrings.yes;
  String cancel() => localizedStrings.cancel;
  String understood() => localizedStrings.understood;
  String done() => localizedStrings.done;
  String ok() => localizedStrings.ok;
  String toSearch() => localizedStrings.toSearch;
  String tryAgain() => localizedStrings.tryAgain;
}
