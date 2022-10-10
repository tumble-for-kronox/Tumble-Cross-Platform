import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/api/dependency_injection/get_it.dart';
import 'package:tumble/core/models/ui_models/school_model.dart';
import 'package:tumble/core/navigation/app_navigator.dart';
import 'package:tumble/core/navigation/navigation_route_labels.dart';
import 'package:tumble/core/shared/preference_types.dart';
import 'package:tumble/core/ui/data/string_constants.dart';
import 'package:tumble/core/ui/init_cubit/init_cubit.dart';
import 'package:tumble/core/ui/login/cubit/auth_cubit.dart';
import 'package:tumble/core/ui/app_switch/data/schools.dart';
import 'package:tumble/core/ui/search/search/school_card.dart';

class SchoolSelectionPage extends StatefulWidget {
  const SchoolSelectionPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SchoolSelectionPage> createState() => _SchoolSelectionPageState();
}

class _SchoolSelectionPageState extends State<SchoolSelectionPage> {
  @override
  Widget build(BuildContext context) {
    final navigator = BlocProvider.of<AppNavigator>(context);
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: Container(
            width: double.infinity,
            height: double.infinity,
            color: Theme.of(context).colorScheme.background,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50, right: 20, left: 20),
                    child: Text(
                      S.settingsPage.chooseUniversity(),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 26,
                      ),
                    ),
                  ),
                  Column(
                    children: Schools.schools
                        .map((school) => SchoolCard(
                            schoolName: school.schoolName,
                            schoolId: school.schoolId,
                            schoolLogo: school.schoolLogo,
                            selectSchool: () => onPressSchool(school, navigator, context)))
                        .toList(),
                  ),
                ],
              ),
            )));
  }
}

void onPressSchool(School school, AppNavigator navigator, BuildContext context) {
  if (school.loginRequired) {
    navigator.push(NavigationRouteLabels.loginPageRoot, arguments: school.schoolName);
  } else if (context.read<InitCubit>().schoolNotNull) {
    BlocProvider.of<InitCubit>(context).changeSchool(school.schoolName).then((_) {
      BlocProvider.of<AuthCubit>(context).logout();
      navigator.pushAndRemoveAll(NavigationRouteLabels.appTopRootBuilder);
    });
  } else {
    BlocProvider.of<InitCubit>(context).changeSchool(school.schoolName).then((_) {
      BlocProvider.of<AuthCubit>(context).logout();
    });
  }
}
