import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:tumble/core/api/apiservices/fetch_response.dart';
import 'package:tumble/core/navigation/app_navigator.dart';
import 'package:tumble/core/navigation/navigation_route_labels.dart';
import 'package:tumble/core/theme/data/colors.dart';
import 'package:tumble/core/ui/init_cubit/init_cubit.dart';
import 'package:tumble/core/ui/login/cubit/auth_cubit.dart';
import 'package:tumble/core/ui/scaffold_message.dart';

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
    return BlocConsumer<AuthCubit, AuthState>(
      listener: ((context, state) async {
        switch (state.authStatus) {
          case AuthStatus.INITIAL:
            if (state.errorMessage != null) {
              showScaffoldMessage(context, state.errorMessage!);
            } else if (BlocProvider.of<AuthCubit>(context).authenticated) {
              BlocProvider.of<AuthCubit>(context).setUserLoggedIn();
            }
            break;
          case AuthStatus.AUTHENTICATED:
            BlocProvider.of<AuthCubit>(context)
                .setUserSession(state.userSession!);
            showScaffoldMessage(context, FetchResponse.loginSuccess);
            BlocProvider.of<InitCubit>(context)
                .changeSchool(widget.schoolName!);
            navigator.pushAndRemoveAll(NavigationRouteLabels.mainAppPage);
            break;
          default:
            break;
        }
      }),
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.primary,
            appBar: _appBar(state, context, navigator),
            resizeToAvoidBottomInset: false,
            body: _initialState(state, context, widget.schoolName!));
      },
    );
  }
}

Widget _initialState(AuthState state, BuildContext context, String school) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 60, bottom: 60),
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: CustomColors.lightColors.background,
                    child: const Image(
                        image: AssetImage('assets/images/tumbleAppLogo.png')),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    state.authStatus == AuthStatus.AUTHENTICATED
                        ? "Signed in to Kronox!"
                        : "Sign in to Kronox",
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
                state.authStatus == AuthStatus.AUTHENTICATED
                    ? "You've sucessfully signed into $school via Kronox"
                    : "Sign in to Kronox with your student credentials\nfor $school for\nthe best user experience",
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
                    if (state.authStatus == AuthStatus.AUTHENTICATED) {
                      return SizedBox(
                        height: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(60.0),
                          child: Lottie.asset(
                              'assets/animations/lottie_success_burst.json',
                              width: 50,
                              height: 50,
                              repeat: false),
                        ),
                      );
                    }
                    switch (state.authStatus) {
                      case AuthStatus.LOADING:
                        return const SpinKitThreeBounce(
                          color: CustomColors.orangePrimary,
                        );
                      case AuthStatus.AUTHENTICATED:
                        return SizedBox(
                          height: double.infinity,
                          child: Lottie.asset(
                              'assets/animations/lottie_success_burst.json',
                              width: 50,
                              height: 50,
                              repeat: false),
                        );
                      default:
                        return _form(state, context, school);
                    }
                  },
                )),
          ],
        ),
      ),
    ],
  );
}

PreferredSizeWidget _appBar(
    AuthState state, BuildContext context, AppNavigator navigator) {
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

Widget _form(AuthState state, BuildContext context, String school) {
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
              _formUsernameField(
                state,
                context,
                school,
              ),
              const SizedBox(
                height: 35,
              ),
              _formPasswordField(state, context, school),
            ],
          ),
          _formSubmitButton(state, context, school),
        ],
      ),
    ),
  );
}

Widget _formSubmitButton(AuthState state, BuildContext context, String school) {
  return Container(
    padding: const EdgeInsets.only(left: 80, right: 80, bottom: 50),
    width: double.infinity,
    height: 105,
    child: OutlinedButton(
      onPressed: () {
        BlocProvider.of<AuthCubit>(context).submitLogin(context, school);
      },
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(CustomColors.orangePrimary),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0))),
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
              child: Text("Sign in",
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ))),
        ],
      ),
    ),
  );
}

Widget _formUsernameField(
    AuthState state, BuildContext context, String school) {
  return Container(
    padding: const EdgeInsets.only(right: 15),
    width: 340,
    child: TextFormField(
      autocorrect: false,
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
          BlocProvider.of<AuthCubit>(context).submitLogin(context, school),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (String? text) {
        return text == "" ? "Username/Email cannot be empty." : null;
      },
    ),
  );
}

Widget _formPasswordField(
    AuthState state, BuildContext context, String school) {
  return Container(
    padding: const EdgeInsets.only(right: 15),
    width: 340,
    child: TextFormField(
      autocorrect: false,
      style: const TextStyle(fontSize: 14),
      controller: state.passwordController,
      obscureText: state.passwordHidden,
      decoration: InputDecoration(
          suffixIcon: IconButton(
              onPressed: () => BlocProvider.of<AuthCubit>(context)
                  .togglePasswordVisibility(),
              icon: !state.passwordHidden
                  ? const Icon(CupertinoIcons.eye)
                  : const Icon(CupertinoIcons.eye_slash)),
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
          BlocProvider.of<AuthCubit>(context).submitLogin(
        context,
        school,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (String? text) {
        return text == "" ? "Password cannot be empty." : null;
      },
    ),
  );
}
