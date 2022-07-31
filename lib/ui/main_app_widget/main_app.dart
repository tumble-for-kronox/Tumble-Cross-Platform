import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tumble/theme/cubit/theme_cubit.dart';
import 'package:tumble/theme/cubit/theme_state.dart';
import 'package:tumble/theme/data/colors.dart';
import 'package:tumble/ui/cubit/init_cubit.dart';
import 'package:tumble/ui/main_app_widget/login_page/login_page_root.dart';
import 'package:tumble/ui/main_app_widget/main_app_navigation_root.dart';
import 'package:tumble/ui/main_app_widget/school_selection_page.dart';
import 'cubit/main_app_cubit.dart';

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
                colorScheme: CustomColors.lightColors,
                fontFamily: 'Roboto',
              ),
              darkTheme: ThemeData(
                colorScheme: CustomColors.darkColors,
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  selectedItemColor: CustomColors.darkColors.primary,
                ),
                fontFamily: 'Roboto',
              ),
              themeMode: state.themeMode,
              home: FutureBuilder(
                  future: context.read<InitCubit>().init(),
                  builder: (context, snapshot) {
                    return BlocListener<InitCubit, InitState>(
                        listener: (context, state) {
                          /* if (state.status == InitStatus.NAVIGATE) {
                            log('Correct');
                            navigator.push(
                              'MainAppNavigationRootPage',
                            );
                          }
                          if (state.status ==
                              InitStatus.NAVIGATE_LOGIN_REQUIRED) {
                            navigator.push('LoginPageRoot');
                          } */
                        },
                        child: const SchoolSelectionPage());
                  }),
            )));
  }
}
