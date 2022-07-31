import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tumble/core/api/apiservices/fetch_response.dart';
import 'package:tumble/core/database/responses/change_response.dart';
import 'package:tumble/core/navigation/app_navigator.dart';
import 'package:tumble/core/theme/data/colors.dart';
import 'package:tumble/core/ui/cubit/init_cubit.dart';
import 'package:tumble/core/ui/main_app_widget/login_page/text_field_container.dart';
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
            backgroundColor: Theme.of(context).colorScheme.primary,
            appBar: _appBar(state, context, navigator),
            body: () {
              switch (state.status) {
                case LoginPageStatus.INITIAL:
                  return _initialState(state, context);
                case LoginPageStatus.LOADING:
                  return SpinKitThreeBounce(
                      color: Theme.of(context).colorScheme.primary);
                default:
                  return _initialState(state, context);
              }
            }());
      },
    );
  }
}

Widget _initialState(LoginPageState state, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 60, bottom: 60),
        child: Center(
          child: Column(
            children: [
              Text(
                "Sign in to Kronox",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.w500,
                  fontSize: 30,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                'This university requires a Kronox\naccount to proceed',
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
      ),
      Expanded(
        child: Stack(
          children: [
            Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
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
                child: _form(state, context)),
          ],
        ),
      ),
    ],
  );
}

PreferredSizeWidget _appBar(
    LoginPageState state, BuildContext context, AppNavigator navigator) {
  return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      leading: IconButton(
          color: Theme.of(context).colorScheme.onBackground,
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
    child: Container(
      padding: const EdgeInsets.only(top: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              _formUsernameField(state, context),
              const SizedBox(
                height: 35,
              ),
              _formPasswordField(state, context),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 90),
            child: _formSubmitButton(state, context),
          ),
        ],
      ),
    ),
  );
}

Widget _formSubmitButton(LoginPageState state, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(left: 80, right: 80),
    child: Expanded(
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: OutlinedButton(
          onPressed: null,
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(CustomColors.orangePrimary),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0))),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                CupertinoIcons.arrow_right_to_line_alt,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              Padding(
                  padding: const EdgeInsets.only(right: 65),
                  child: Text("Sign in",
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ))),
            ],
          ),
        ),
      ),
    ),
  );

  /* return MaterialButton(
    color: Theme.of(context).colorScheme.primary,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
    onPressed: () =>
        BlocProvider.of<LoginPageCubit>(context).submitLogin(context),
    child: const Text("Sign in"),
  ); */
}

Widget _formUsernameField(LoginPageState state, BuildContext context) {
  return Container(
    padding: const EdgeInsets.only(right: 15),
    width: 340,
    child: TextFormField(
      style: const TextStyle(fontSize: 14),
      controller: state.usernameController,
      decoration: InputDecoration(
          icon: Icon(
            CupertinoIcons.person,
            color: Theme.of(context).colorScheme.onBackground,
          ),
          labelText: 'Username/Email',
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 1, color: CustomColors.orangePrimary.withOpacity(.5)),
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 1, color: CustomColors.orangePrimary.withOpacity(.5)),
            borderRadius: BorderRadius.circular(20),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 1,
                color: const Color.fromARGB(255, 235, 36, 5).withOpacity(.5)),
            borderRadius: BorderRadius.circular(20),
          ),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 1,
                  color: const Color.fromARGB(255, 235, 36, 5).withOpacity(.5)),
              borderRadius: BorderRadius.circular(20))),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (String s) =>
          BlocProvider.of<LoginPageCubit>(context).submitLogin(context),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (String? text) {
        return text == "" ? "Username/Email cannot be empty." : null;
      },
    ),
  );
}

Widget _formPasswordField(LoginPageState state, BuildContext context) {
  return Container(
    padding: const EdgeInsets.only(right: 15),
    width: 340,
    child: TextFormField(
      style: const TextStyle(fontSize: 14),
      controller: state.passwordController,
      obscureText: true,
      decoration: InputDecoration(
          icon: Icon(CupertinoIcons.lock,
              color: Theme.of(context).colorScheme.onBackground),
          labelText: 'Password',
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 1, color: CustomColors.orangePrimary.withOpacity(.5)),
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 1, color: CustomColors.orangePrimary.withOpacity(.5)),
            borderRadius: BorderRadius.circular(20),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 1,
                color: const Color.fromARGB(255, 235, 36, 5).withOpacity(.5)),
            borderRadius: BorderRadius.circular(20),
          ),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 1,
                  color: const Color.fromARGB(255, 235, 36, 5).withOpacity(.5)),
              borderRadius: BorderRadius.circular(20))),
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (String s) =>
          BlocProvider.of<LoginPageCubit>(context).submitLogin(context),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (String? text) {
        return text == "" ? "Password cannot be empty." : null;
      },
    ),
  );
}
