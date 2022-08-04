import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/shared/preference_types.dart';
import 'package:tumble/core/startup/get_it_instances.dart';
import 'package:tumble/core/theme/data/colors.dart';
import 'package:tumble/core/ui/login/cubit/auth_cubit.dart';
import 'package:tumble/core/ui/main_app/data/schools.dart';

class UserAccountInfo extends StatefulWidget {
  const UserAccountInfo({Key? key}) : super(key: key);

  @override
  State<UserAccountInfo> createState() => _UserAccountInfo();
}

class _UserAccountInfo extends State<UserAccountInfo> {
  @override
  Widget build(BuildContext context) => Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 120),
            color: CustomColors.orangePrimary,
            child: Container(
                padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                child: Container(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        BlocProvider.of<AuthCubit>(context)
                            .state
                            .userSession!
                            .name,
                        style: TextStyle(
                            fontSize: 32,
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Icon(
                            CupertinoIcons.book,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            locator<SharedPreferences>()
                                .getString(PreferenceTypes.school)!,
                            style: TextStyle(
                                fontSize: 16,
                                color:
                                    Theme.of(context).colorScheme.onSecondary),
                          ),
                        ],
                      )
                    ],
                  ),
                )),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              padding: const EdgeInsets.only(top: 70, right: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  Schools.schools
                      .where((school) =>
                          school.schoolName ==
                          locator<SharedPreferences>()
                              .getString(PreferenceTypes.school))
                      .first
                      .schoolLogo,
                  height: 100,
                  width: 100,
                ),
              ),
            ),
          ),
        ],
      );
}
