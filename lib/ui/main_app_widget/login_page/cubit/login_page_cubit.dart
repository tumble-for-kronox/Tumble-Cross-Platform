part of 'login_page_state.dart';

class LoginPageCubit extends Cubit<LoginPageState> {
  LoginPageCubit()
      : super(LoginPageState(
          status: LoginPageStatus.INITIAL,
          usernameController: TextEditingController(),
          passwordController: TextEditingController(),
          rememberUser: false,
        ));

  final _userRepo = locator<UserRepository>();
  final _secureStorage = locator<SecureStorageRepository>();

  void submitLogin(BuildContext context) async {
    final username = state.usernameController.text;
    final password = state.passwordController.text;

    if (!formValidated()) {
      emit(state.copyWith(status: LoginPageStatus.INITIAL, errorMessage: "Username and password cannot be empty."));
      return;
    }

    emit(state.copyWith(status: LoginPageStatus.LOADING));
    ApiResponse userRes = await _userRepo.postUserLogin(username, password);

    switch (userRes.status) {
      case ApiStatus.REQUESTED:
        if (state.rememberUser!) {
          storeUserCreds(username, password);
        }
        emit(state.copyWith(status: LoginPageStatus.SUCCESS, userSession: userRes.data!));
        break;
      case ApiStatus.ERROR:
        emit(state.copyWith(status: LoginPageStatus.INITIAL, errorMessage: userRes.message));
        break;
      default:
    }
  }

  bool formValidated() {
    final password = state.passwordController.text;
    final username = state.usernameController.text;
    return password != "" && username != "";
  }

  void setSchool(School school) {
    emit(state.copyWith(school: school));
  }

  void emitCleanInitState() {
    emit(LoginPageState(
      status: LoginPageStatus.INITIAL,
      usernameController: TextEditingController(),
      passwordController: TextEditingController(),
      rememberUser: false,
    ));
  }

  void updateRememberMe(bool? value) {
    log(value.toString());
    emit(state.copyWith(rememberUser: value));
    log(state.rememberUser.toString());
  }

  void storeUserCreds(String username, String password) {
    _secureStorage.setUsername(username);
    _secureStorage.setPassword(password);
  }
}
