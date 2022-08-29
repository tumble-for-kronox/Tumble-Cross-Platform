import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/navigation/app_navigator.dart';
import 'package:tumble/core/navigation/navigation_route_labels.dart';
import 'package:tumble/core/ui/data/scaffold_message_types.dart';
import 'package:tumble/core/ui/init_cubit/init_cubit.dart';
import 'package:tumble/core/ui/login/cubit/auth_cubit.dart';
import 'package:tumble/core/ui/main_app/data/schools.dart';
import 'package:tumble/core/ui/scaffold_message.dart';
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
                    "Choose your university",
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
                          selectSchool: () {
                            if (school.loginRequired) {
                              navigator.push(
                                  NavigationRouteLabels.loginPageRoot,
                                  arguments: school.schoolName);
                            } else {
                              BlocProvider.of<InitCubit>(context)
                                  .changeSchool(school.schoolName);
                              BlocProvider.of<AuthCubit>(context).logout();
                              showScaffoldMessage(
                                  context,
                                  ScaffoldMessageType.changedSchool(
                                      BlocProvider.of<InitCubit>(context)
                                          .state
                                          .defaultSchool!));
                              navigator.pushAndRemoveAll(
                                  NavigationRouteLabels.mainAppPage);
                            }
                          }))
                      .toList(),
                ),
              ],
            ),
          )),
    );
  }
}
