import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/shared/preference_types.dart';
import 'package:tumble/core/dependency_injection/get_it_instances.dart';
import 'package:tumble/core/theme/data/colors.dart';
import 'package:tumble/core/ui/account/misc/login_logout_button.dart';
import 'package:tumble/core/ui/account/misc/user_account_info_external_link.dart';
import 'package:tumble/core/ui/login/cubit/auth_cubit.dart';
import 'package:tumble/core/ui/main_app/data/schools.dart';
import 'package:tumble/core/ui/scaffold_message.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UserAccountInfo extends StatefulWidget {
  const UserAccountInfo({Key? key}) : super(key: key);

  @override
  State<UserAccountInfo> createState() => _UserAccountInfo();
}

class _UserAccountInfo extends State<UserAccountInfo> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
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
                          color: Theme.of(context).colorScheme.onBackground.withOpacity(.3),
                          offset: const Offset(1.0, 1.0),
                          blurRadius: 2),
                    ],
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hello!',
                                style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onSecondary),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                maxLines: 2,
                                softWrap: true,
                                BlocProvider.of<AuthCubit>(context).state.userSession!.name,
                                style: TextStyle(fontSize: 22, color: Theme.of(context).colorScheme.onBackground),
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
                                    getIt<SharedPreferences>().getString(PreferenceTypes.school)!,
                                    style: TextStyle(fontSize: 15, color: Theme.of(context).colorScheme.onSecondary),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, right: 10),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: Image.asset(
                                Schools.schools
                                    .where((school) =>
                                        school.schoolName ==
                                        getIt<SharedPreferences>().getString(PreferenceTypes.school))
                                    .first
                                    .schoolLogo,
                                height: 100,
                                width: 100,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                UserAccountExternalLink(
                  title: "Your Canvas",
                  color: const Color(0xFFe23e29),
                  link:
                      "https://${Schools.schools.firstWhere((school) => school.schoolName == getIt<SharedPreferences>().getString(PreferenceTypes.school)).schoolId.name}.instructure.com",
                ),
                const SizedBox(
                  height: 20,
                ),
                const UserAccountExternalLink(
                  title: "Your Ladok",
                  color: Color(0xFF3c9a00),
                  link: "https://www.student.ladok.se/student/app/studentwebb/",
                ),
                const SizedBox(
                  height: 20,
                ),
                UserAccountExternalLink(
                  title:
                      "Kronox for ${Schools.schools.firstWhere((school) => school.schoolName == getIt<SharedPreferences>().getString(PreferenceTypes.school)).schoolName}",
                  color: const Color(0xFF0089da),
                  link:
                      "https://${Schools.schools.firstWhere((school) => school.schoolName == getIt<SharedPreferences>().getString(PreferenceTypes.school)).schoolUrl}",
                ),
                const SizedBox(
                  height: 50,
                ),
                FractionallySizedBox(
                  widthFactor: 0.6,
                  child: LoginLogoutButton(
                      onPressed: () {
                        BlocProvider.of<AuthCubit>(context).logout();
                      },
                      icon: CupertinoIcons.arrow_left_square,
                      text: "Sign out"),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
