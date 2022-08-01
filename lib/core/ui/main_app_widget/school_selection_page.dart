import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/database/responses/change_response.dart';
import 'package:tumble/core/navigation/app_navigator.dart';
import 'package:tumble/core/navigation/navigation_route_labels.dart';
import 'package:tumble/core/ui/cubit/init_cubit.dart';
import 'package:tumble/core/ui/main_app_widget/data/schools.dart';
import 'package:tumble/core/ui/main_app_widget/misc/tumble_drawer/cubit/drawer_state.dart';
import 'package:tumble/core/ui/main_app_widget/search_page_widgets/search/school_card.dart';
import 'package:tumble/core/ui/scaffold_message.dart';

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
                                  .changeSchool(school);
                              showScaffoldMessage(context,
                                  '${ChangeResponse.changeSchool} ${BlocProvider.of<InitCubit>(context).state.defaultSchool}');
                              navigator.pushAndRemoveAll(NavigationRouteLabels
                                  .mainAppNavigationRootPage);
                              BlocProvider.of<DrawerCubit>(context)
                                  .setNameForNextSchool(school.schoolName);
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
