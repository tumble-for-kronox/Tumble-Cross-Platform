import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/api/backend/repository/cache_repository.dart';
import 'package:tumble/core/api/dependency_injection/get_it.dart';
import 'package:tumble/core/models/ui_models/school_model.dart';
import 'package:tumble/core/navigation/navigation_route_labels.dart';
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
  final _cacheAndInteractionService = getIt<CacheRepository>();

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
                    padding: const EdgeInsets.only(
                        top: 80, right: 20, left: 20, bottom: 20),
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

  void onPressSchool(School school, BuildContext context) {
    log(
        name: 'school_selection_page',
        'Setting ${school.schoolName} as default');
    _cacheAndInteractionService.changeSchool(school.schoolName).then((_) {
      _cacheAndInteractionService.setFirstTimeLaunched(true);
      BlocProvider.of<AuthCubit>(context).logout();
    });
    Navigator.pop(context);
  }
}
