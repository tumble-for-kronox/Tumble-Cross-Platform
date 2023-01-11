import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';
import 'package:tumble/core/navigation/navigation_route_labels.dart';
import 'package:tumble/core/theme/cubit/theme_cubit.dart';
import 'package:tumble/core/theme/cubit/theme_state.dart';
import 'package:tumble/core/theme/data/colors.dart';
import 'package:tumble/core/ui/app_switch/app_switch.dart';
import 'package:tumble/core/ui/app_switch/school_selection_page.dart';
import 'package:tumble/core/ui/cubit/auth_cubit.dart';
import 'package:tumble/core/ui/data/string_constants.dart';
import 'package:tumble/core/ui/login/login_page_root.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        BlocProvider<ThemeCubit>(
            create: (context) => ThemeCubit()
              ..getCurrentTheme()
              ..getCurrentLang()),
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: ((context, state) => MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Tumble for Kronox',
              localizationsDelegates: const [
                GlobalCupertinoLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                AppLocalizations.delegate,
                SfGlobalLocalizations.delegate
              ],
              routes: {
                NavigationRouteLabels.appSwitchPage: (context) =>
                    const AppSwitch(),
                NavigationRouteLabels.loginPageRoot: (context) =>
                    const LoginPageRoot(),
                NavigationRouteLabels.schoolSelectionPage: (context) =>
                    const SchoolSelectionPage(),
              },
              supportedLocales: const [
                Locale('en'),
                Locale('sv'),
                Locale('fr'),
                Locale('de'),
                Locale('zh'),
              ],
              locale: state.locale,
              localeResolutionCallback: (locale, supportedLocales) =>
                  supportedLocales.contains(locale)
                      ? locale
                      : const Locale('en'),
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
              home: Builder(builder: (context) {
                S.init(context);
                return const AppSwitch();
              })))),
    );
  }
}
