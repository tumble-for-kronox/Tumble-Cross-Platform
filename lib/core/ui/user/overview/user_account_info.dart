import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/ui/cubit/auth_cubit.dart';
import 'package:tumble/core/ui/data/string_constants.dart';
import 'package:tumble/core/ui/app_switch/data/schools.dart';
import 'package:tumble/core/ui/tumble_button.dart';
import 'package:tumble/core/ui/user/misc/auto_signup_option.dart';
import 'package:tumble/core/ui/user/misc/user_account_info_external_link.dart';
import 'package:tumble/core/ui/user/overview/external_link_container.dart';
import 'package:tumble/core/ui/user/overview/user_account_container.dart';
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
                      const UserAccountContainer(),
                      const SizedBox(
                        height: 40,
                      ),
                      _sectionDivider(
                          context,
                          S.authorizedPage.userOptionsTitle(),
                          CupertinoIcons.gear),
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
                      _sectionDivider(
                          context,
                          S.authorizedPage.userBookingsTitle(),
                          CupertinoIcons.building_2_fill),
                      const SizedBox(
                        height: 10,
                      ),
                      const UserBookingsContainer(),
                      const SizedBox(
                        height: 40,
                      ),
                      _sectionDivider(
                          context,
                          S.authorizedPage.externalLinksTitle(),
                          CupertinoIcons.link),
                      const SizedBox(
                        height: 20,
                      ),
                      const ExternalLinkContainer(),
                      const SizedBox(
                        height: 40,
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
