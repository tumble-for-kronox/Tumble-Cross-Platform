import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tumble/refactor/ui/cubit/root_page_cubit.dart';
import 'package:tumble/theme/cubit/theme_cubit.dart';
import 'package:tumble/theme/cubit/theme_state.dart';
import 'package:tumble/theme/data/colors.dart';
import 'package:tumble/ui/cubit/init_cubit.dart';
import 'package:tumble/ui/main_app_widget/login_page/login_page_root.dart';
import 'package:tumble/ui/main_app_widget/main_app_navigation_root.dart';
import 'package:tumble/ui/main_app_widget/school_selection_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
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
                  future: context.read<RootPageCubit>().init(),
                  builder: (context, snapshot) {
                    return BlocListener<InitCubit, InitState>(
                        listener: (context, state) {},
                        child: const SchoolSelectionPage());
                  }),
            )));
  }
}
