import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tumble/core/api/apiservices/fetch_response.dart';
import 'package:tumble/core/navigation/app_navigator.dart';
import 'package:tumble/core/ui/cubit/init_cubit.dart';
import 'package:tumble/core/ui/main_app_widget/misc/tumble_drawer/auth_cubit/auth_cubit.dart';
import 'package:tumble/core/ui/main_app_widget/login_page/cubit/login_page_state.dart';
import 'package:tumble/core/ui/scaffold_message.dart';

class LoginPageRoot extends StatefulWidget {
  const LoginPageRoot({Key? key}) : super(key: key);

  @override
  State<LoginPageRoot> createState() => _LoginPageRootState();
}

class _LoginPageRootState extends State<LoginPageRoot> {
  @override
  Widget build(BuildContext context) {
    final navigator = BlocProvider.of<AppNavigator>(context);
    return BlocConsumer<LoginPageCubit, LoginPageState>(
      listener: ((context, state) {
        if (state.status == LoginPageStatus.SUCCESS) {
          showScaffoldMessage(context, FetchResponse.loginSuccess);
          BlocProvider.of<AuthCubit>(context)
              .setUserSession(state.userSession!);
          if (state.school != null) {
            BlocProvider.of<InitCubit>(context).changeSchool(state.school!);
          } else {
            navigator.pop();
          }
        } else if (state.status == LoginPageStatus.INITIAL &&
            state.errorMessage != null) {
          showScaffoldMessage(context, state.errorMessage!);
          BlocProvider.of<LoginPageCubit>(context).emitCleanInitState();
        }
      }),
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: _appBar(state, context, navigator),
          body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: () {
                  switch (state.status) {
                    case LoginPageStatus.INITIAL:
                      return _initialState(state, context);
                    case LoginPageStatus.LOADING:
                      return SpinKitThreeBounce(
                          color: Theme.of(context).colorScheme.primary);
                    default:
                      return _initialState(state, context);
                  }
                }()),
          ),
        );
      },
    );
  }
}

Widget _initialState(LoginPageState state, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Text(
          "Login to Kronox",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
      ),
      _form(state, context),
    ],
  );
}

PreferredSizeWidget _appBar(
    LoginPageState state, BuildContext context, AppNavigator navigator) {
  return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            state.passwordController.clear();
            state.usernameController.clear();
            navigator.pop();
          }));
}

Widget _form(LoginPageState state, BuildContext context) {
  return Form(
    onWillPop: () async {
      state.passwordController.clear();
      state.usernameController.clear();
      return true;
    },
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _formUsernameField(state, context),
        _formPasswordField(state, context),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: _formSubmitButton(state, context),
        ),
      ],
    ),
  );
}

Widget _formSubmitButton(LoginPageState state, BuildContext context) {
  return MaterialButton(
    color: Theme.of(context).colorScheme.primary,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
    onPressed: () =>
        BlocProvider.of<LoginPageCubit>(context).submitLogin(context),
    child: const Text("Login"),
  );
}

Widget _formUsernameField(LoginPageState state, BuildContext context) {
  return TextFormField(
    controller: state.usernameController,
    decoration: InputDecoration(
      icon: Icon(
        CupertinoIcons.person,
        color: Theme.of(context).colorScheme.onBackground,
      ),
      label: const Text("Username"),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
    ),
    keyboardType: TextInputType.emailAddress,
    textInputAction: TextInputAction.done,
    onFieldSubmitted: (String s) =>
        BlocProvider.of<LoginPageCubit>(context).submitLogin(context),
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: (String? text) {
      return text == "" ? "Username/Email cannot be empty." : null;
    },
  );
}

Widget _formPasswordField(LoginPageState state, BuildContext context) {
  return TextFormField(
    controller: state.passwordController,
    obscureText: true,
    decoration: InputDecoration(
      icon: Icon(
        CupertinoIcons.lock,
        color: Theme.of(context).colorScheme.onBackground,
      ),
      label: const Text("Password"),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
    ),
    textInputAction: TextInputAction.done,
    onFieldSubmitted: (String s) =>
        BlocProvider.of<LoginPageCubit>(context).submitLogin(context),
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: (String? text) {
      return text == "" ? "Password cannot be empty." : null;
    },
  );
}
