import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/navigation/app_navigator.dart';

class LoginPageRoot extends StatefulWidget {
  const LoginPageRoot({Key? key}) : super(key: key);

  @override
  State<LoginPageRoot> createState() => _LoginPageRootState();
}

class _LoginPageRootState extends State<LoginPageRoot> {
  @override
  Widget build(BuildContext context) {
    final AppNavigator navigator = BlocProvider.of<AppNavigator>(context);
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                navigator.pop();
              })),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text("Login"),
              Form(
                  child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: "username",
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: "password",
                    ),
                  ),
                  TextButton(
                    onPressed: () => {},
                    child: const Text("Login"),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
