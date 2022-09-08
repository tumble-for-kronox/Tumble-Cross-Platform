import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/theme/cubit/theme_cubit.dart';
import 'package:tumble/core/theme/cubit/theme_state.dart';
import 'package:tumble/core/ui/bottom_nav_bar/cubit/bottom_nav_cubit.dart';
import 'package:tumble/core/ui/init_cubit/init_cubit.dart';
import 'package:tumble/core/ui/login/cubit/auth_cubit.dart';
import 'package:tumble/core/ui/main_app/main_app_navigation_root.dart';
import 'package:tumble/core/ui/main_app/school_selection_page.dart';
import 'package:tumble/core/ui/user/cubit/user_event_cubit.dart';

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
        builder: ((context, state) => FutureBuilder(
            future: BlocProvider.of<InitCubit>(context).init(),
            builder: (context, snapshot) {
              return BlocBuilder<InitCubit, InitState>(
                builder: (context, state) {
                  switch (state.status) {
                    case InitStatus.NO_SCHOOL:
                      return BlocProvider.value(
                        value: BlocProvider.of<InitCubit>(context),
                        child: const SchoolSelectionPage(),
                      );
                    case InitStatus.SCHOOL_AVAILABLE:
                      return MultiBlocProvider(providers: [
                        BlocProvider.value(
                            value: BlocProvider.of<AuthCubit>(context)),
                        BlocProvider<UserEventCubit>(
                            create: (context) => UserEventCubit()),
                        BlocProvider<MainAppNavigationCubit>(
                            create: (context) => MainAppNavigationCubit())
                      ], child: const MainAppNavigationRootPage());
                  }
                },
              );
            })));
  }
}
