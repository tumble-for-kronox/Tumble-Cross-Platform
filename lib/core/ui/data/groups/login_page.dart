import 'package:tumble/core/ui/data/string_constant_group.dart';

class LoginPageStrings extends StringConstantGroup {
  LoginPageStrings(super.localizedStrings);

  String title() => localizedStrings.loginPageTitle;
  String description(String universityName) => localizedStrings.loginPageDescription(universityName);
  String usernamePlaceholder() => localizedStrings.loginPageUsernamePlaceholder;
  String passwordPlaceholder() => localizedStrings.loginPagePasswordPlaceholder;
  String signInButton() => localizedStrings.signInButtonTitle;
  String loginSuccessTitle() => localizedStrings.loginPageSuccessTitle;
  String loginSuccessDescription(String universityName) => localizedStrings.loginPageSuccessDescription(universityName);
  String emailValidationError() => localizedStrings.loginEmailValidationError;
  String passwordValidationError() => localizedStrings.loginPasswordValidationError;
}
