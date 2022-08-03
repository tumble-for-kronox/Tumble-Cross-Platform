import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/shared/preference_types.dart';
import 'package:tumble/core/startup/get_it_instances.dart';
import 'package:tumble/core/theme/data/colors.dart';
import 'package:tumble/core/ui/account/user_event_list/cubit/user_event_list_cubit.dart';
import 'package:tumble/core/ui/account/user_event_list/user_event_list.dart';
import 'package:tumble/core/ui/account/user_info.dart';
import 'package:tumble/core/ui/login/cubit/auth_cubit.dart';
import 'package:tumble/core/ui/main_app/data/schools.dart';

class AuthenticatedPage extends StatelessWidget {
  const AuthenticatedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: CustomColors.orangePrimary,
                ),
                Container(
                    height: MediaQuery.of(context).size.height / 2.1,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10))),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Container(
                        padding: const EdgeInsets.only(left: 20, top: 20),
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(15)),
                        child: Text(
                          BlocProvider.of<AuthCubit>(context)
                              .state
                              .userSession!
                              .name,
                          style: TextStyle(
                              fontSize: 32,
                              color:
                                  Theme.of(context).colorScheme.onBackground),
                        ),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                        height: 160,
                        width: MediaQuery.of(context).size.width - 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).colorScheme.secondary),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Stack(
                                alignment: Alignment.bottomLeft,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        CupertinoIcons.book,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        locator<SharedPreferences>()
                                            .getString(PreferenceTypes.school)!,
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding:
                                            const EdgeInsets.only(right: 95),
                                        child: Text(
                                          DateFormat('EEEE')
                                              .format(DateTime.now()),
                                          style: TextStyle(
                                              fontSize: 22,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onBackground),
                                        ),
                                      ),
                                      Container(
                                        padding:
                                            const EdgeInsets.only(bottom: 50),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Image.asset(
                                            Schools.schools
                                                .where((school) =>
                                                    school.schoolName ==
                                                    locator<SharedPreferences>()
                                                        .getString(
                                                            PreferenceTypes
                                                                .school))
                                                .first
                                                .schoolLogo,
                                            height: 90,
                                            width: 90,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        )),
                  ),
                )
              ],
            ),
          ),
          /* UserInfo(
            name: BlocProvider.of<AuthCubit>(context).state.userSession!.name,
            loggedIn: true,
            onPressed: () {
              BlocProvider.of<AuthCubit>(context).logout();
            },
          ),
          const SizedBox(
            height: 60,
          ),
          BlocProvider.value(
              value: BlocProvider.of<AuthCubit>(context),
              child: const UserEventList()), */
        ],
      ),
    );
  }
}
