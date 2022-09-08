import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/shared/preference_types.dart';
import 'package:tumble/core/dependency_injection/get_it_instances.dart';
import 'package:tumble/core/ui/data/string_constants.dart';
import 'package:tumble/core/ui/main_app/data/schools.dart';
import 'package:tumble/core/ui/tumble_button.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({Key? key, this.name, required this.loggedIn, required this.onPressed}) : super(key: key);

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
                  .where((school) => school.schoolName == getIt<SharedPreferences>().getString(PreferenceTypes.school))
                  .first
                  .schoolLogo)),
          const SizedBox(
            height: 25,
          ),
          Text(
            S.unauthorizedPage.description(),
            textAlign: TextAlign.center,
            style:
                TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.onBackground),
          ),
          FractionallySizedBox(
            widthFactor: 0.6,
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: TumbleButton(
                onPressed: onPressed,
                prefixIcon: CupertinoIcons.person_circle,
                text: S.loginPage.signInButton(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
