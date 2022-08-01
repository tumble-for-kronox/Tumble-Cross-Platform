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
        color: CustomColors.orangePrimary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40.0),
          bottomRight: Radius.circular(40.0),
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black87.withOpacity(.3),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50.0,
            backgroundColor: Theme.of(context).colorScheme.secondary,
            child: Icon(
              size: 50,
              CupertinoIcons.person,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            'Hello $name!',
            style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary, fontSize: 16),
          )
        ],
      ),
    );
  }
}
