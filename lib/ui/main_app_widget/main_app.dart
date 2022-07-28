import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:tumble/theme/cubit/theme_cubit.dart';
import 'package:tumble/theme/cubit/theme_state.dart';
import 'package:tumble/theme/data/colors.dart';
import 'package:tumble/ui/cubit/init_cubit.dart';
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
  Widget build(BuildContext context) => BlocBuilder<ThemeCubit, ThemeState>(
      builder: ((context, state) => GetMaterialApp(
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
                  return BlocBuilder<InitCubit, InitState>(
                    builder: (context, state) {
                      switch (state.status) {
                        case InitStatus.HAS_SCHOOL:
                          return const MainAppNavigationRoot();
                        case InitStatus.INITIAL:
                        case InitStatus.NO_SCHOOL:
                          return const SchoolSelectionPage();
                      }
                    },
                  );
                }),
          )));
}
