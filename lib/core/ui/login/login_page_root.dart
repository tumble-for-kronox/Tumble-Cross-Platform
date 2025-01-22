import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:tumble/core/api/backend/response_types/runtime_error_type.dart';
import 'package:tumble/core/theme/data/colors.dart';
import 'package:tumble/core/ui/cubit/auth_cubit.dart';
import 'package:tumble/core/ui/cubit/login_cubit.dart';
import 'package:tumble/core/ui/data/string_constants.dart';
import 'package:tumble/core/ui/scaffold_message.dart';
import 'package:tumble/core/ui/tumble_loading.dart';


class LoginPageRoot extends StatefulWidget {
  const LoginPageRoot({super.key});

  @override
  State<LoginPageRoot> createState() => _LoginPageRootState();
}

class _LoginPageRootState extends State<LoginPageRoot> {
  late Map<dynamic, dynamic> _arguments;
  late String _schoolName;
  late LoginCubit _loginCubit;

  @override
  void initState() {
    _loginCubit = LoginCubit();
    super.initState();
  }

  @override
  void dispose() {
    _loginCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _arguments = (ModalRoute.of(context)?.settings.arguments) as Map;
    _schoolName = _arguments['schoolName'];
    return BlocProvider.value(
      value: _loginCubit,
      child: BlocListener<LoginCubit, LoginState>(
          listener: ((_, state) async {
            switch (state.status) {
              case LoginStatus.SUCCESS:
                showScaffoldMessage(context, RuntimeErrorType.loginSuccess());
                context.read<AuthCubit>().login().then((value) {
                  Future.delayed(const Duration(seconds: 1)).then((value) => Navigator.of(context).pop());
                });
                break;
              default:
                break;
            }
          }),
          child: Scaffold(
              backgroundColor: Theme.of(context).colorScheme.primary,
              appBar: _appBar(context),
              resizeToAvoidBottomInset: false,
              body: _initialState(context, _schoolName))),
    );
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
        BlocBuilder<LoginCubit, LoginState>(
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
                                    backgroundColor: CustomColors.lightColors.surface,
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
                    color: Theme.of(context).colorScheme.surface,
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
                  child: BlocBuilder<LoginCubit, LoginState>(
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
                        case LoginStatus.LOADING:
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

PreferredSizeWidget _appBar(BuildContext context) {
  return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      leadingWidth: 120,
      leading: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          return ElevatedButton.icon(
            icon: Icon(
              CupertinoIcons.chevron_back,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            onPressed: () {
              state.passwordController.clear();
              state.usernameController.clear();
              Navigator.of(context).pop();
            },
            label: Text(
              S.general.back(),
              style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onSurface),
            ),
          );
        },
      ));
}

Widget _form(BuildContext context, String school) {
  return BlocBuilder<LoginCubit, LoginState>(
    builder: (context, state) {
      return Form(
        onWillPop: () async {
          state.passwordController.clear();
          state.usernameController.clear();
          context.read<LoginCubit>().setFocusFalse();
          return true;
        },
        child: Container(
          padding: const EdgeInsets.only(top: 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AutofillGroup(
                  child: Column(
                children: [
                  _formUsernameField(
                    context,
                    school,
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  _formPasswordField(context, school),
                  if (state.status == LoginStatus.FAIL)
                    Container(
                      padding: const EdgeInsets.only(top: 40),
                      child: Text(
                        RuntimeErrorType.loginError(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red),
                      ),
                    )
                ],
              )),
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
        BlocProvider.of<LoginCubit>(context).submitLogin(context, school);
      },
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(CustomColors.orangePrimary),
        shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0))),
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
    child: BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return TextFormField(
          focusNode: context.read<LoginCubit>().focusNodeUsername,
          autocorrect: false,
          autofillHints: const [AutofillHints.email],
          style: const TextStyle(fontSize: 14),
          controller: state.usernameController,
          decoration: InputDecoration(
              icon: Icon(
                CupertinoIcons.person,
                color: Theme.of(context).colorScheme.onSurface,
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
          onFieldSubmitted: (String s) => BlocProvider.of<LoginCubit>(context).submitLogin(context, school),
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
    child: BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return TextFormField(
          focusNode: context.read<LoginCubit>().focusNodePassword,
          autocorrect: false,
          autofillHints: const [AutofillHints.password],
          style: const TextStyle(fontSize: 14),
          controller: state.passwordController,
          obscureText: state.passwordHidden,
          decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () => BlocProvider.of<LoginCubit>(context).togglePasswordVisibility(),
                  icon: Icon(
                    !state.passwordHidden ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(.9),
                  )),
              icon: Icon(CupertinoIcons.lock, color: Theme.of(context).colorScheme.onSurface),
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
          onFieldSubmitted: (String s) => BlocProvider.of<LoginCubit>(context).submitLogin(
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
