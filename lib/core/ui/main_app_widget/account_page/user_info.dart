import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tumble/core/theme/data/colors.dart';

class UserInfo extends StatelessWidget {
  const UserInfo(
      {Key? key, this.name, required this.loggedIn, required this.onPressed})
      : super(key: key);

  final String? name;
  final bool loggedIn;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40.0),
          bottomRight: Radius.circular(40.0),
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
        ),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50.0,
            backgroundColor: Theme.of(context).colorScheme.onSecondary,
            child: Icon(
              size: 50,
              CupertinoIcons.person,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            loggedIn
                ? "Welcome ${name!.split(" ")[0]}"
                : "Connect your Kronox account by logging in.",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.onBackground),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 70, right: 70),
            child: OutlinedButton(
                onPressed: onPressed,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      CustomColors.orangePrimary),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0))),
                ),
                child: Text(loggedIn ? "Sign out" : "Sign in",
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ))),
          ),
        ],
      ),
    );
  }
}
