import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({Key? key, this.name, required this.loggedIn, required this.onPressed}) : super(key: key);

  final String? name;
  final bool loggedIn;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 30, top: 10),
            child: Icon(
              size: 100,
              CupertinoIcons.person_circle_fill,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          Text(
            loggedIn ? "Welcome ${name!.split(" ")[0]}!" : "Connect your Kronox account by logging in.",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: TextButton(
              onPressed: onPressed,
              child: Text(
                loggedIn ? "Logout" : "Login",
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
