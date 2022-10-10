import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:tumble/core/api/backend/response_types/runtime_error_type.dart';
import 'package:tumble/core/navigation/app_navigator.dart';
import 'package:tumble/core/navigation/navigation_route_labels.dart';
import 'package:tumble/core/theme/data/colors.dart';
import 'package:tumble/core/ui/data/string_constants.dart';
import 'package:tumble/core/ui/login/cubit/auth_cubit.dart';
import 'package:tumble/core/ui/scaffold_message.dart';
import 'package:tumble/core/ui/tumble_loading.dart';

class LoginPageRoot extends StatefulWidget {
  final String? schoolName;
  const LoginPageRoot({Key? key, this.schoolName}) : super(key: key);

  @override
  State<LoginPageRoot> createState() => _LoginPageRootState();
}

class _LoginPageRootState extends State<LoginPageRoot> {
  @override
  Widget build(BuildContext context) {
    final navigator = BlocProvider.of<AppNavigator>(context);
    return BlocListener<AuthCubit, AuthState>(
        listener: ((context, state) async {
          switch (state.status) {
            case AuthStatus.INITIAL:
              if (state.errorMessage != null &&
                  (state.passwordController.text.isNotEmpty || state.usernameController.text.isNotEmpty)) {
                showScaffoldMessage(context, state.errorMessage!);
              } else if (BlocProvider.of<AuthCubit>(context).authenticated) {
                BlocProvider.of<AuthCubit>(context).setUserLoggedIn();
              }
              break;
            case AuthStatus.AUTHENTICATED:
              BlocProvider.of<AuthCubit>(context).setUserSession(state.userSession!);
              showScaffoldMessage(context, RuntimeErrorType.loginSuccess());
              navigator.pushAndRemoveAll(NavigationRouteLabels.appSwitchPage);
              break;
            default:
              break;
          }
        }),
        child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.primary,
            appBar: _appBar(context, navigator),
            resizeToAvoidBottomInset: false,
            body: _initialState(context, widget.schoolName!)));
  }
}

Widget _initialState(BuildContext context, String school) {
  return Container(
    padding: const EdgeInsets.only(top: 30),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// This widget should be dynamic, toggling its visibility based
        /// on the focusnode on each input field in the login form.
        BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return AnimatedSize(
              duration: const Duration(milliseconds: 200),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: !state.focused
                    ? Padding(
                        padding: const EdgeInsets.only(top: 60, bottom: 60),
                        child: Center(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: CustomColors.lightColors.background,
                                    child: const Image(image: AssetImage('assets/images/ic_launcher.png')),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    state.loginSuccess ? S.loginPage.loginSuccessTitle() : S.loginPage.title(),
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.onPrimary,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 31,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Text(
                                state.loginSuccess
                                    ? S.loginPage.loginSuccessDescription(school)
                                    : S.loginPage.description(school),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onPrimary,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : Container(),
              ),
            );
          },
        ),
        Expanded(
          child: Stack(
            children: [
              Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(40.0),
                      topLeft: Radius.circular(40.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black87.withOpacity(.1),
                        offset: const Offset(0.0, -3.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      if (state.loginSuccess) {
                        return SizedBox(
                          height: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(60.0),
                            child: Lottie.asset('assets/animations/lottie_success_burst.json',
                                width: 50, height: 50, repeat: false),
                          ),
                        );
                      }
                      switch (state.status) {
                        case AuthStatus.LOADING:
                          if (state.loginSuccess) {
                            return SizedBox(
                              height: double.infinity,
                              child: Lottie.asset('assets/animations/lottie_success_burst.json',
                                  width: 50, height: 50, repeat: false),
                            );
                          }
                          return const TumbleLoading();
                        default:
                          return _form(context, school);
                      }
                    },
                  )),
            ],
          ),
        ),
      ],
    ),
  );
}

PreferredSizeWidget _appBar(BuildContext context, AppNavigator navigator) {
  return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      leadingWidth: 100,
      leading: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return ElevatedButton.icon(
            icon: Icon(
              CupertinoIcons.chevron_back,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            style: ElevatedButton.styleFrom(
              elevation: 0,
              primary: Colors.transparent,
            ),
            onPressed: () {
              state.passwordController.clear();
              state.usernameController.clear();
              navigator.pop();
            },
            label: Text(
              S.general.back(),
              style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onBackground),
            ),
          );
        },
      ));
}

Widget _form(BuildContext context, String school) {
  return BlocBuilder<AuthCubit, AuthState>(
    builder: (context, state) {
      return Form(
        onWillPop: () async {
          state.passwordController.clear();
          state.usernameController.clear();
          context.read<AuthCubit>().setFocusFalse();
          return true;
        },
        child: Container(
          padding: const EdgeInsets.only(top: 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  _formUsernameField(
                    context,
                    school,
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  _formPasswordField(context, school),
                  if (state.status == AuthStatus.ERROR)
                    Container(
                      padding: const EdgeInsets.only(top: 40),
                      child: const Text(
                        'Something went wrong!\nTry again later',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.red),
                      ),
                    )
                ],
              ),
              _formSubmitButton(context, school),
            ],
          ),
        ),
      );
    },
  );
}

Widget _formSubmitButton(BuildContext context, String school) {
  return Container(
    padding: const EdgeInsets.only(left: 80, right: 80, bottom: 50),
    width: double.infinity,
    height: 105,
    child: OutlinedButton(
      onPressed: () {
        BlocProvider.of<AuthCubit>(context).submitLogin(context, school);
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(CustomColors.orangePrimary),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            CupertinoIcons.arrow_right_square,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          Padding(
              padding: const EdgeInsets.only(right: 65),
              child: Text(S.loginPage.signInButton(),
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ))),
        ],
      ),
    ),
  );
}

Widget _formUsernameField(BuildContext context, String school) {
  return Container(
    padding: const EdgeInsets.only(right: 15),
    width: 340,
    child: BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return TextFormField(
          focusNode: context.read<AuthCubit>().focusNodeUsername,
          autocorrect: false,
          style: const TextStyle(fontSize: 14),
          controller: state.usernameController,
          decoration: InputDecoration(
              icon: Icon(
                CupertinoIcons.person,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              labelText: S.loginPage.usernamePlaceholder(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: CustomColors.orangePrimary.withOpacity(.5)),
                borderRadius: BorderRadius.circular(20),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: CustomColors.orangePrimary.withOpacity(.5)),
                borderRadius: BorderRadius.circular(20),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: const Color.fromARGB(255, 235, 36, 5).withOpacity(.5)),
                borderRadius: BorderRadius.circular(20),
              ),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: const Color.fromARGB(255, 235, 36, 5).withOpacity(.5)),
                  borderRadius: BorderRadius.circular(20))),
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (String s) => BlocProvider.of<AuthCubit>(context).submitLogin(context, school),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (String? text) {
            return text == "" ? S.loginPage.emailValidationError() : null;
          },
        );
      },
    ),
  );
}

Widget _formPasswordField(BuildContext context, String school) {
  return Container(
    padding: const EdgeInsets.only(right: 15),
    width: 340,
    child: BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return TextFormField(
          focusNode: context.read<AuthCubit>().focusNodePassword,
          autocorrect: false,
          style: const TextStyle(fontSize: 14),
          controller: state.passwordController,
          obscureText: state.passwordHidden,
          decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () => BlocProvider.of<AuthCubit>(context).togglePasswordVisibility(),
                  icon: Icon(
                    !state.passwordHidden ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
                    color: Theme.of(context).colorScheme.onBackground.withOpacity(.9),
                  )),
              icon: Icon(CupertinoIcons.lock, color: Theme.of(context).colorScheme.onBackground),
              labelText: S.loginPage.passwordPlaceholder(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: CustomColors.orangePrimary.withOpacity(.5)),
                borderRadius: BorderRadius.circular(20),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: CustomColors.orangePrimary.withOpacity(.5)),
                borderRadius: BorderRadius.circular(20),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: const Color.fromARGB(255, 235, 36, 5).withOpacity(.5)),
                borderRadius: BorderRadius.circular(20),
              ),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: const Color.fromARGB(255, 235, 36, 5).withOpacity(.5)),
                  borderRadius: BorderRadius.circular(20))),
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (String s) => BlocProvider.of<AuthCubit>(context).submitLogin(
            context,
            school,
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (String? text) {
            return text == "" ? S.loginPage.passwordValidationError() : null;
          },
        );
      },
    ),
  );
}
