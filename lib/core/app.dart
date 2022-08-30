import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/navigation/app_navigator.dart';
import 'package:tumble/core/navigation/app_navigator_provider.dart';
import 'package:tumble/core/navigation/navigation_route_labels.dart';
import 'package:tumble/core/theme/cubit/theme_cubit.dart';
import 'package:tumble/core/theme/cubit/theme_state.dart';
import 'package:tumble/core/theme/data/colors.dart';
import 'package:tumble/core/ui/init_cubit/init_cubit.dart';
import 'package:tumble/core/ui/login/cubit/auth_cubit.dart';
import 'package:tumble/core/ui/main_app/cubit/main_app_cubit.dart';
import 'package:tumble/core/ui/search/cubit/search_page_cubit.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppNavigator>(create: (_) => AppNavigator()),
        BlocProvider<InitCubit>(create: (_) => InitCubit()),
        BlocProvider<AuthCubit>(create: (_) => AuthCubit()),
        BlocProvider<ThemeCubit>(
            create: (_) => ThemeCubit()..getCurrentTheme()),
        BlocProvider<SearchPageCubit>(create: (context) => SearchPageCubit()),
        BlocProvider<MainAppCubit>(create: (context) => MainAppCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
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
              home: MultiBlocProvider(
                providers: [
                  BlocProvider.value(
                      value: BlocProvider.of<AppNavigator>(context)),
                  BlocProvider.value(
                      value: BlocProvider.of<InitCubit>(context)),
                  BlocProvider.value(
                      value: BlocProvider.of<AuthCubit>(context)),
                  BlocProvider.value(
                      value: BlocProvider.of<ThemeCubit>(context)),
                  BlocProvider.value(
                      value: BlocProvider.of<SearchPageCubit>(context)),
                ],
                child: const AppNavigatorProvider(initialPages: [
                  NavigationRouteLabels.mainAppPage,
                ]),
              )))),
    );
  }
}
