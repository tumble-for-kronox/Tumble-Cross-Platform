import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tumble/core/api/preferences/repository/preference_repository.dart';
import 'package:tumble/core/api/dependency_injection/get_it.dart';
import 'package:tumble/core/ui/data/string_constants.dart';
import 'package:tumble/core/ui/app_switch/data/schools.dart';
import 'package:tumble/core/ui/tumble_button.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key, this.name, required this.loggedIn, required this.onPressed});

  final String? name;
  final bool loggedIn;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      width: double.infinity,
      child: Column(
        children: [
          CircleAvatar(
              radius: 50.0,
              backgroundColor: Theme.of(context).colorScheme.onSecondary,
              child: Image.asset(Schools.schools
                  .where((school) => school.schoolName == getIt<PreferenceRepository>().defaultSchool)
                  .first
                  .schoolLogo)),
          const SizedBox(
            height: 25,
          ),
          Text(
            S.unauthorizedPage.description(),
            textAlign: TextAlign.center,
            style:
                TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.onSurface),
          ),
          FractionallySizedBox(
            widthFactor: 0.6,
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: TumbleButton(
                onPressed: onPressed,
                prefixIcon: CupertinoIcons.person_circle,
                text: S.loginPage.signInButton(),
                loading: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
