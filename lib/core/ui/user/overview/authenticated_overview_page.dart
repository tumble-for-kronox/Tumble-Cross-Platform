import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/theme/data/colors.dart';
import 'package:tumble/core/ui/cubit/auth_cubit.dart';
import 'package:tumble/core/ui/cubit/resource_cubit.dart';
import 'package:tumble/core/ui/cubit/user_event_cubit.dart';
import 'package:tumble/core/ui/user/events/user_event_list.dart';
import 'package:tumble/core/ui/user/overview/user_account_info.dart';
import 'package:tumble/core/ui/user/resources/tumble_resource_page.dart';

class AuthenticatedOverviewPage extends StatefulWidget {
  const AuthenticatedOverviewPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AuthenticatedPage();
}

class _AuthenticatedPage extends State<AuthenticatedOverviewPage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final tabController = TabController(
          initialIndex:
              BlocProvider.of<UserEventCubit>(context).state.currentTabIndex!,
          length: 3,
          vsync: this);
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
                    CupertinoIcons.person_circle,
                    color: Theme.of(context).colorScheme.onBackground,
                    size: 25,
                  ),
                ),
                Tab(
                  icon: Icon(
                    CupertinoIcons.calendar_badge_plus,
                    color: Theme.of(context).colorScheme.onBackground,
                    size: 25,
                  ),
                ),
                Tab(
                  icon: Icon(
                    CupertinoIcons.building_2_fill,
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
                  child: UserAccountInfo(
                    onRefresh: () async =>
                        await context.read<ResourceCubit>().getUserBookings(
                              context.read<AuthCubit>().logout,
                            ),
                  ),
                ),
                BlocProvider.value(
                  value: BlocProvider.of<AuthCubit>(context),
                  child: Events(
                    onRefresh: () async => await context
                        .read<UserEventCubit>()
                        .getUserEvents(
                            context.read<AuthCubit>().state.status,
                            context.read<AuthCubit>().setUserSession,
                            context.read<AuthCubit>().logout,
                            context.read<AuthCubit>().state.userSession!,
                            true),
                  ),
                ),
                BlocProvider.value(
                  value: BlocProvider.of<AuthCubit>(context),
                  child: ResourcePage(
                    onSchoolResourcesRefresh: () async =>
                        await context.read<ResourceCubit>().getSchoolResources(
                              context.read<AuthCubit>().state.userSession!,
                              context.read<AuthCubit>().setUserSession,
                              context.read<AuthCubit>().logout,
                            ),
                  ),
                )
              ]),
            ),
          )
        ],
      );
    });
  }
}
