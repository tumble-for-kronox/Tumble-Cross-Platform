import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tumble/theme/colors.dart';
import 'package:tumble/ui/home_page_widget/home_page.dart';
import 'package:tumble/ui/home_page_widget/school_selection_page.dart';
import 'package:tumble/ui/search_page_widgets/search/schedule_search_page.dart';
import 'cubit/main_app_cubit.dart';

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) => MaterialApp(
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
        home: FutureBuilder(
            future: context.read<MainAppCubit>().init(),
            builder: (context, snapshot) {
              return BlocBuilder<MainAppCubit, MainAppState>(
                builder: (context, state) {
                  if (state is MainAppSchoolSelectedAndDefault) {
                    return HomePage(currentScheduleId: state.currentScheduleId);
                  } else if (state is MainAppSchoolSelected) {
                    return const ScheduleSearchPage();
                  }
                  return SchoolSelectionPage(
                      schoolsList: context.read<MainAppCubit>().schools);
                },
              );
            }),
      );
}
