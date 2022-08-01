import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/theme/cubit/theme_cubit.dart';
import 'package:tumble/core/theme/cubit/theme_state.dart';
import 'package:tumble/core/theme/data/colors.dart';
import 'package:tumble/core/ui/cubit/init_cubit.dart';
import 'package:tumble/core/ui/main_app_widget/main_app_navigation_root.dart';
import 'package:tumble/core/ui/main_app_widget/school_selection_page.dart';

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
                bottomSheetTheme: const BottomSheetThemeData(
                    backgroundColor: Colors.transparent),
                colorScheme: CustomColors.lightColors,
                fontFamily: 'Roboto',
              ),
              darkTheme: ThemeData(
                bottomSheetTheme: const BottomSheetThemeData(
                    backgroundColor: Colors.transparent),
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
                          case InitStatus.INITIAL:
                            return const SchoolSelectionPage();
                          case InitStatus.HAS_SCHOOL:
                            return const MainAppNavigationRootPage();
                        }
                      },
                    );
                  }),
            )));
  }
}
