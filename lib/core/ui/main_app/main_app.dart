import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';
import 'package:tumble/core/theme/cubit/theme_cubit.dart';
import 'package:tumble/core/theme/cubit/theme_state.dart';
import 'package:tumble/core/theme/data/colors.dart';
import 'package:tumble/core/ui/bottom_nav_bar/cubit/bottom_nav_cubit.dart';
import 'package:tumble/core/ui/init_cubit/init_cubit.dart';
import 'package:tumble/core/ui/login/cubit/auth_cubit.dart';
import 'package:tumble/core/ui/main_app/main_app_navigation_root.dart';
import 'package:tumble/core/ui/main_app/school_selection_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../data/string_constants.dart';

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
        builder: ((context, state) => MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Tumble',
              theme: ThemeData(
                bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.transparent),
                colorScheme: CustomColors.lightColors,
                fontFamily: 'Roboto',
              ),
              darkTheme: ThemeData(
                bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.transparent),
                colorScheme: CustomColors.darkColors,
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  selectedItemColor: CustomColors.darkColors.primary,
                ),
                fontFamily: 'Roboto',
              ),
              themeMode: state.themeMode,
              home: FutureBuilder(
                  future: BlocProvider.of<InitCubit>(context).init(),
                  builder: (context, snapshot) {
                    return BlocBuilder<InitCubit, InitState>(
                      builder: (context, state) {
                        switch (state.status) {
                          case InitStatus.INITIAL:
                            return BlocProvider.value(
                              value: BlocProvider.of<InitCubit>(context),
                              child: const SchoolSelectionPage(),
                            );
                          case InitStatus.HAS_SCHOOL:
                            return MultiBlocProvider(providers: [
                              BlocProvider.value(value: BlocProvider.of<AuthCubit>(context)),
                              BlocProvider<MainAppNavigationCubit>(create: (_) => MainAppNavigationCubit())
                            ], child: const MainAppNavigationRootPage());
                        }
                      },
                    );
                  }),
            )));

  }
}
