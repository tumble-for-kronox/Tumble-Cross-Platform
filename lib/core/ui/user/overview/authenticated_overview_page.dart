import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/theme/data/colors.dart';
import 'package:tumble/core/ui/login/cubit/auth_cubit.dart';
import 'package:tumble/core/ui/user/events/user_event_list.dart';
import 'package:tumble/core/ui/user/overview/user_account_info.dart';
import 'package:tumble/core/ui/user/resources/tumble_resource_page.dart';

class AuthenticatedOverviewPage extends StatefulWidget {
  const AuthenticatedOverviewPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AuthenticatedPage();
}

class _AuthenticatedPage extends State<AuthenticatedOverviewPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);
    return Column(
      children: [
        TabBar(
            controller: tabController,
            indicatorColor: CustomColors.orangePrimary,
            labelStyle: const TextStyle(fontSize: 17),
            labelColor: Theme.of(context).colorScheme.onBackground,
            tabs: [
              Tab(
                icon: Icon(
                  CupertinoIcons.person,
                  color: Theme.of(context).colorScheme.onBackground,
                  size: 25,
                ),
              ),
              Tab(
                icon: Icon(
                  CupertinoIcons.news,
                  color: Theme.of(context).colorScheme.onBackground,
                  size: 25,
                ),
              ),
              Tab(
                icon: Icon(
                  CupertinoIcons.house,
                  color: Theme.of(context).colorScheme.onBackground,
                  size: 25,
                ),
              )
            ]),
        Expanded(
          child: SizedBox(
            width: double.maxFinite,
            child: TabBarView(controller: tabController, children: [
              BlocProvider.value(
                value: BlocProvider.of<AuthCubit>(context),
                child: const UserAccountInfo(),
              ),
              BlocProvider.value(
                value: BlocProvider.of<AuthCubit>(context),
                child: const Events(),
              ),
              BlocProvider.value(
                value: BlocProvider.of<AuthCubit>(context),
                child: const ResourcePage(),
              )
            ]),
          ),
        )
      ],
    );
  }
}
