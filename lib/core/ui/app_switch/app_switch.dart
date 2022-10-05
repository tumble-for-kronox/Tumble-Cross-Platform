import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/theme/cubit/theme_cubit.dart';
import 'package:tumble/core/theme/cubit/theme_state.dart';
import 'package:tumble/core/ui/bottom_nav_bar/cubit/bottom_nav_cubit.dart';
import 'package:tumble/core/ui/init_cubit/init_cubit.dart';
import 'package:tumble/core/ui/login/cubit/auth_cubit.dart';
import 'package:tumble/core/ui/app_switch//initialized_navigation_root_page.dart';
import 'package:tumble/core/ui/app_switch/school_selection_page.dart';
import 'package:tumble/core/ui/user/cubit/user_event_cubit.dart';
import 'package:tumble/core/ui/user/resources/cubit/resource_cubit.dart';

class AppSwitch extends StatefulWidget {
  const AppSwitch({Key? key}) : super(key: key);

  @override
  State<AppSwitch> createState() => _AppSwitchState();
}

class _AppSwitchState extends State<AppSwitch> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
        builder: ((context, state) => BlocBuilder<InitCubit, InitState>(
              builder: (context, state) {
                switch (state.status) {
                  case InitStatus.NO_SCHOOL:
                    return BlocProvider.value(
                      value: BlocProvider.of<InitCubit>(context),
                      child: const SchoolSelectionPage(),
                    );
                  case InitStatus.SCHOOL_AVAILABLE:
                    return MultiBlocProvider(providers: [
                      BlocProvider.value(value: BlocProvider.of<AuthCubit>(context)),
                      BlocProvider<UserEventCubit>(create: (context) => UserEventCubit()),
                      BlocProvider<ResourceCubit>(create: (context) => ResourceCubit()),
                      BlocProvider<MainAppNavigationCubit>(create: (context) => MainAppNavigationCubit())
                    ], child: const InitializedNavigationRootPage());
                }
              },
            )));
  }
}
