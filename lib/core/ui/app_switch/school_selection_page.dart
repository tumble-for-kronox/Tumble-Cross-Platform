import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/models/ui_models/school_model.dart';
import 'package:tumble/core/navigation/navigation_route_labels.dart';
import 'package:tumble/core/ui/cubit/app_switch_cubit.dart';
import 'package:tumble/core/ui/cubit/auth_cubit.dart';
import 'package:tumble/core/ui/data/string_constants.dart';
import 'package:tumble/core/ui/app_switch/data/schools.dart';
import 'package:tumble/core/ui/search/school_card.dart';

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
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: Container(
            width: double.infinity,
            height: double.infinity,
            color: Theme.of(context).colorScheme.background,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 80, right: 20, left: 20, bottom: 20),
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
                            selectSchool: () => onPressSchool(school, context)))
                        .toList(),
                  ),
                ],
              ),
            )));
  }
}

void onPressSchool(School school, BuildContext context) {
  if (school.loginRequired) {
    Navigator.of(context).pushNamed(NavigationRouteLabels.loginPageRoot, arguments: {'schoolName': school.schoolName});
    return;
  } else if (context.read<AppSwitchCubit>().schoolNotNull) {
    BlocProvider.of<AppSwitchCubit>(context).changeSchool(school.schoolName).then((_) {
      BlocProvider.of<AuthCubit>(context).logout();
      Navigator.pushNamedAndRemoveUntil(context, NavigationRouteLabels.appSwitchPage, (route) => false);
    });
  } else {
    BlocProvider.of<AppSwitchCubit>(context).changeSchool(school.schoolName).then((_) {
      BlocProvider.of<AuthCubit>(context).logout();
    });
  }
}
