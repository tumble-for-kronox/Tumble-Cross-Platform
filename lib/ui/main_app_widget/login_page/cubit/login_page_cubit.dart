part of 'login_page_state.dart';

class LoginPageCubit extends Cubit<LoginPageState> {
  LoginPageCubit() : super(LoginPageState(status: LoginPageStatus.INITIAL));

  final _userRepo = locator<UserRepository>();
  final _databaseRepo = locator<DatabaseRepository>();

  void submitLogin(BuildContext context) async {
    emit(state.copyWith(status: LoginPageStatus.LOADING));

    ApiResponse userRes = await _userRepo.postUserLogin(state.usernameController.text, state.passwordController.text);

    switch (userRes.status) {
      case ApiStatus.REQUESTED:
        _databaseRepo.setUserSession(userRes.data!);
        emit(state.copyWith(status: LoginPageStatus.SUCCESS));
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

    return password == "" || username == "";
  }

  void setSchool(School school) {
    emit(state.copyWith(school: school));
  }
}
