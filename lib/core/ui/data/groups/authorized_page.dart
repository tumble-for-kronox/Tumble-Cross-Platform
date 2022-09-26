import 'package:tumble/core/ui/data/string_constant_group.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthorizedPageStrings extends StringConstantGroup {
  AuthorizedPageStrings(AppLocalizations localizedStrings) : super(localizedStrings);

  String title() => localizedStrings.accountPageTitle;
  String hello() => localizedStrings.authorizedPageHello;
  String userOptionsTitle() => localizedStrings.authorizedPageUserOptionsTitle;
  String automaticExamSignup() => localizedStrings.authorizedPageAutomaticExamSignup;
  String userBookingsTitle() => localizedStrings.authorizedPageUserBookingsTitle;
  String externalLinksTitle() => localizedStrings.authorizedPageExternalLinksTitle;
  String personalExternalLink(String webpageName) => localizedStrings.authorizedPagePersonalExternalLink(webpageName);
  String externalLinkKronox(String universityName) =>
      localizedStrings.authorizedPageExternalLinksKronox(universityName);

  String signOut() => localizedStrings.signOutButtonTitle;
}
