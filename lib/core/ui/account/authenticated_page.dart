import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/shared/preference_types.dart';
import 'package:tumble/core/startup/get_it_instances.dart';
import 'package:tumble/core/theme/data/colors.dart';
import 'package:tumble/core/ui/account/user_account_info.dart';
import 'package:tumble/core/ui/account/user_event_list/cubit/user_event_list_cubit.dart';
import 'package:tumble/core/ui/account/user_event_list/user_event_list.dart';
import 'package:tumble/core/ui/account/user_info.dart';
import 'package:tumble/core/ui/login/cubit/auth_cubit.dart';
import 'package:tumble/core/ui/main_app/data/schools.dart';

class AuthenticatedPage extends StatefulWidget {
  const AuthenticatedPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AuthenticatedPage();
}

class _AuthenticatedPage extends State<AuthenticatedPage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);
    return Column(
      children: [
        TabBar(
            controller: tabController,
            indicatorColor: CustomColors.orangePrimary,
            labelStyle: const TextStyle(fontSize: 17),
            labelColor: Theme.of(context).colorScheme.onBackground,
            tabs: const [
              Tab(
                icon: Icon(
                  CupertinoIcons.person,
                  size: 25,
                ),
              ),
              Tab(
                icon: Icon(CupertinoIcons.pencil_ellipsis_rectangle, size: 25),
              )
            ]),
        Container(
          padding: const EdgeInsets.only(bottom: 5),
          height: MediaQuery.of(context).size.height - 245,
          width: double.maxFinite,
          child: TabBarView(controller: tabController, children: [
            BlocProvider.value(
              value: BlocProvider.of<AuthCubit>(context),
              child: const UserAccountInfo(),
            ),
            Container(),
          ]),
        )
      ],
    );
  }
}
