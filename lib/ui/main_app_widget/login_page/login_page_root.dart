import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tumble/models/ui_models/school_model.dart';
import 'package:tumble/ui/auth_cubit/auth_cubit.dart';
import 'package:tumble/ui/cubit/init_cubit.dart';
import 'package:tumble/ui/main_app_widget/login_page/cubit/login_page_state.dart';
import 'package:tumble/ui/scaffold_message.dart';

import '../../../api/apiservices/fetch_response.dart';
import '../../../theme/data/colors.dart';

class LoginPageRoot extends StatefulWidget {
  const LoginPageRoot({Key? key}) : super(key: key);

  @override
  State<LoginPageRoot> createState() => _LoginPageRootState();
}

class _LoginPageRootState extends State<LoginPageRoot> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginPageCubit, LoginPageState>(
      listener: ((context, state) {
        if (state.status == LoginPageStatus.SUCCESS) {
          showScaffoldMessage(context, FetchResponse.loginSuccess);
          BlocProvider.of<AuthCubit>(context).setUserSession(state.userSession!);
          BlocProvider.of<InitCubit>(context).changeSchool(context, state.school!);
        } else if (state.status == LoginPageStatus.INITIAL && state.errorMessage != null) {
          showScaffoldMessage(context, state.errorMessage!);
          BlocProvider.of<LoginPageCubit>(context).emitCleanInitState();
        }
      }),
      builder: (context, state) {
        return Scaffold(
          appBar: _appBar(state, context),
          body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: () {
                  switch (state.status) {
                    case LoginPageStatus.INITIAL:
                      return _initialState(state, context);
                    case LoginPageStatus.LOADING:
                      return const SpinKitThreeBounce(color: CustomColors.orangePrimary);
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
    children: [
      const Text("Login"),
      _form(state, context),
    ],
  );
}

PreferredSizeWidget _appBar(LoginPageState state, BuildContext context) {
  return AppBar(
      leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            state.passwordController.clear();
            state.usernameController.clear();
            Navigator.of(context).pop();
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
      children: [
        _formUsernameField(state, context),
        _formPasswordField(state, context),
        _formRememberMeCheckBox(state, context),
        _formSubmitButton(state, context),
      ],
    ),
  );
}

Widget _formSubmitButton(LoginPageState state, BuildContext context) {
  return TextButton(
    onPressed: () => BlocProvider.of<LoginPageCubit>(context).submitLogin(context),
    child: const Text("Login"),
  );
}

Widget _formRememberMeCheckBox(LoginPageState state, BuildContext context) {
  return Checkbox(
    value: state.rememberUser,
    onChanged: (value) => BlocProvider.of<LoginPageCubit>(context).updateRememberMe(value),
  );
}

Widget _formUsernameField(LoginPageState state, BuildContext context) {
  return TextFormField(
    controller: state.usernameController,
    decoration: const InputDecoration(
      label: Text("Username"),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
    ),
    keyboardType: TextInputType.emailAddress,
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
    decoration: const InputDecoration(
      label: Text("Password"),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
    ),
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: (String? text) {
      return text == "" ? "Password cannot be empty." : null;
    },
  );
}
