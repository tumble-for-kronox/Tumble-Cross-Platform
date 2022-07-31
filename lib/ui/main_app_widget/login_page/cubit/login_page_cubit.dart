part of 'login_page_state.dart';

class LoginPageCubit extends Cubit<LoginPageState> {
  LoginPageCubit()
      : super(LoginPageState(
          status: LoginPageStatus.INITIAL,
          usernameController: TextEditingController(),
          passwordController: TextEditingController(),
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

    state.usernameController.clear();
    state.passwordController.clear();
    switch (userRes.status) {
      case ApiStatus.REQUESTED:
        storeUserCreds((userRes.data! as KronoxUserModel).refreshToken);
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

  void setSchool(School? school) {
    emit(state.copyWith(school: school));
  }

  void emitCleanInitState() {
    emit(LoginPageState(
      status: LoginPageStatus.INITIAL,
      usernameController: TextEditingController(),
      passwordController: TextEditingController(),
    ));
  }

  void storeUserCreds(String token) {
    _secureStorage.setRefreshToken(token);
  }
}
