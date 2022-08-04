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
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Column(
              children: [
                Container(
                  height: 150,
                  padding: const EdgeInsets.only(left: 20, top: 30),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(.3),
                          offset: const Offset(1.0, 1.0),
                          blurRadius: 2),
                    ],
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello!',
                        style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.onSecondary),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        BlocProvider.of<AuthCubit>(context)
                            .state
                            .userSession!
                            .name,
                        style: TextStyle(
                            fontSize: 22,
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Icon(
                            CupertinoIcons.book,
                            color: Theme.of(context).colorScheme.onSecondary,
                            size: 18,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            locator<SharedPreferences>()
                                .getString(PreferenceTypes.school)!,
                            style: TextStyle(
                                fontSize: 15,
                                color:
                                    Theme.of(context).colorScheme.onSecondary),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 40),
                  width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: 165,
                        height: 250,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onBackground
                                    .withOpacity(.3),
                                offset: const Offset(1.0, 1.0),
                                blurRadius: 2),
                          ],
                          color: const Color(0xFF717EC3),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      CupertinoIcons.pen,
                                      size: 16,
                                      color:
                                          CustomColors.lightColors.background,
                                    ),
                                    Text(
                                      'Upcoming exams',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: CustomColors
                                              .lightColors.background),
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      ),
                      Container(
                        width: 165,
                        height: 250,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onBackground
                                    .withOpacity(.3),
                                offset: const Offset(1.0, 1.0),
                                blurRadius: 2),
                          ],
                          color: const Color(0xFF7CAE7A),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      CupertinoIcons.pen,
                                      size: 16,
                                      color:
                                          CustomColors.lightColors.background,
                                    ),
                                    Text('Upcoming exams',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: CustomColors
                                              .lightColors.background,
                                        )),
                                  ],
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, right: 20),
            child: Align(
              alignment: Alignment.topRight,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
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
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 40,
              width: 120,
              child: OutlinedButton(
                onPressed: () {
                  BlocProvider.of<AuthCubit>(context).logout();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      CustomColors.orangePrimary),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0))),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      CupertinoIcons.arrow_right_square,
                      color: Theme.of(context).colorScheme.onPrimary,
                      size: 18,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text("Sign out",
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ))),
                  ],
                ),
              ),
            ),
          )
        ],
      );
}
