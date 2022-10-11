import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/shared/preference_types.dart';
import 'package:tumble/core/api/dependency_injection/get_it.dart';
import 'package:tumble/core/ui/data/string_constants.dart';
import 'package:tumble/core/ui/login/cubit/auth_cubit.dart';
import 'package:tumble/core/ui/app_switch/data/schools.dart';
import 'package:tumble/core/ui/tumble_button.dart';
import 'package:tumble/core/ui/user/misc/auto_signup_option.dart';
import 'package:tumble/core/ui/user/misc/user_account_info_external_link.dart';
import 'package:tumble/core/ui/user/overview/user_bookings.dart';

class UserAccountInfo extends StatefulWidget {
  final Future<void> Function() onRefresh;

  const UserAccountInfo({Key? key, required this.onRefresh}) : super(key: key);

  @override
  State<UserAccountInfo> createState() => _UserAccountInfo();
}

class _UserAccountInfo extends State<UserAccountInfo> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: widget.onRefresh,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 2, offset: Offset(0, 1))],
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
                                      S.authorizedPage.hello(),
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
                                          context.read<AuthCubit>().defaultSchool,
                                          style:
                                              TextStyle(fontSize: 15, color: Theme.of(context).colorScheme.onSecondary),
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
                                          .where(
                                              (school) => school.schoolName == context.read<AuthCubit>().defaultSchool)
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
                        height: 50,
                      ),
                      _sectionDivider(context, S.authorizedPage.userOptionsTitle(), CupertinoIcons.gear),
                      const SizedBox(
                        height: 10,
                      ),
                      BlocProvider.value(
                        value: BlocProvider.of<AuthCubit>(context),
                        child: const AutoSignupOption(),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      _sectionDivider(context, S.authorizedPage.userBookingsTitle(), Icons.other_houses_outlined),
                      const SizedBox(
                        height: 10,
                      ),
                      const UserBookingsContainer(),
                      const SizedBox(
                        height: 40,
                      ),
                      _sectionDivider(context, S.authorizedPage.externalLinksTitle(), CupertinoIcons.link),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          UserAccountExternalLink(
                            title: "Canvas",
                            color: const Color(0xFFe23e29),
                            icon: CupertinoIcons.link,
                            link:
                                "https://${Schools.schools.firstWhere((school) => school.schoolName == context.read<AuthCubit>().defaultSchool).schoolId.name}.instructure.com",
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const UserAccountExternalLink(
                            title: "Ladok",
                            color: Color(0xFF3c9a00),
                            icon: CupertinoIcons.link,
                            link: "https://www.student.ladok.se/student/app/studentwebb/",
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          UserAccountExternalLink(
                            title: "Kronox",
                            color: const Color(0xFF0089da),
                            icon: CupertinoIcons.link,
                            link:
                                "https://${Schools.schools.firstWhere((school) => school.schoolName == context.read<AuthCubit>().defaultSchool).schoolUrl}",
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                      FractionallySizedBox(
                          widthFactor: 0.6,
                          child: TumbleButton(
                            onPressed: () {
                              BlocProvider.of<AuthCubit>(context).logout();
                            },
                            prefixIcon: CupertinoIcons.arrow_left_square,
                            text: S.authorizedPage.signOut(),
                            loading: false,
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget _sectionDivider(BuildContext context, String title, IconData icon) {
  return Row(
    children: [
      Container(
        padding: const EdgeInsets.only(left: 10, right: 8, bottom: 2.7),
        child: Icon(
          icon,
          color: Theme.of(context).colorScheme.onBackground,
          size: 16,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 12),
        child: Text(
          title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
            fontWeight: FontWeight.w500,
            fontSize: 16,
            letterSpacing: 0.5,
          ),
        ),
      ),
      Expanded(
        child: Divider(
          color: Theme.of(context).colorScheme.onBackground,
          thickness: 0.1,
        ),
      ),
    ],
  );
}
