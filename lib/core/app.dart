import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';
import 'package:tumble/core/navigation/app_navigator.dart';
import 'package:tumble/core/navigation/app_navigator_provider.dart';
import 'package:tumble/core/navigation/navigation_route_labels.dart';
import 'package:tumble/core/theme/cubit/theme_cubit.dart';
import 'package:tumble/core/theme/cubit/theme_state.dart';
import 'package:tumble/core/theme/data/colors.dart';
import 'package:tumble/core/ui/data/string_constants.dart';
import 'package:tumble/core/ui/init_cubit/init_cubit.dart';
import 'package:tumble/core/ui/login/cubit/auth_cubit.dart';
import 'package:tumble/core/ui/main_app/cubit/main_app_cubit.dart';
import 'package:tumble/core/ui/search/cubit/search_page_cubit.dart';
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
        BlocProvider<AppNavigator>(create: (_) => AppNavigator()),
        BlocProvider<InitCubit>(create: (_) => InitCubit()),
        BlocProvider<AuthCubit>(create: (_) => AuthCubit()),
        BlocProvider<ThemeCubit>(
            create: (_) => ThemeCubit()
              ..getCurrentTheme()
              ..getCurrentLang()),
        BlocProvider<SearchPageCubit>(create: (_) => SearchPageCubit()),
        BlocProvider<MainAppCubit>(create: (_) => MainAppCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: ((context, state) => MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Tumble',
              localizationsDelegates: const [
                GlobalCupertinoLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                AppLocalizations.delegate,
                SfGlobalLocalizations.delegate
              ],
              supportedLocales: AppLocalizations.supportedLocales,
              locale: state.locale,
              localeResolutionCallback: (locale, supportedLocales) =>
                  supportedLocales.contains(locale) ? locale : const Locale('en'),
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
              home: Builder(builder: (context) {
                S.init(context);
                return MultiBlocProvider(
                  providers: [
                    BlocProvider.value(value: BlocProvider.of<AppNavigator>(context)),
                    BlocProvider.value(value: BlocProvider.of<InitCubit>(context)),
                    BlocProvider.value(value: BlocProvider.of<AuthCubit>(context)),
                    BlocProvider.value(value: BlocProvider.of<ThemeCubit>(context)),
                    BlocProvider.value(value: BlocProvider.of<SearchPageCubit>(context)),
                  ],
                  child: const AppNavigatorProvider(initialPages: [
                    NavigationRouteLabels.mainAppPage,
                  ]),
                );
              })))),
    );
  }
}
