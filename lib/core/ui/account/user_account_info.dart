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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello!',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSecondary),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              BlocProvider.of<AuthCubit>(context)
                                  .state
                                  .userSession!
                                  .name,
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                Icon(
                                  CupertinoIcons.book,
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
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
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, right: 10),
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
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 40),
                  width: double.maxFinite,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: 320,
                        height: 140,
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
                                  children: [
                                    Icon(
                                      CupertinoIcons.pen,
                                      size: 16,
                                      color:
                                          CustomColors.lightColors.background,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(left: 2),
                                      child: Text(
                                        'Upcoming exams',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: CustomColors
                                                .lightColors.background),
                                      ),
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 320,
                        height: 140,
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
                                  children: [
                                    Icon(
                                      CupertinoIcons.pen,
                                      size: 16,
                                      color:
                                          CustomColors.lightColors.background,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text('Courses',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: CustomColors
                                                .lightColors.background,
                                          )),
                                    ),
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
        ],
      );
}
