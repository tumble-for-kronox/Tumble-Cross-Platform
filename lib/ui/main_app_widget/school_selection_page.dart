import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumble/ui/cubit/init_cubit.dart';
import 'package:tumble/ui/main_app_widget/data/schools.dart';
import 'package:tumble/ui/main_app_widget/search_page_widgets/search/school_card.dart';

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
    log(context.read<InitCubit>().state.status.toString());
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
                            selectSchool: (schoolName) => {
                              context
                                  .read<InitCubit>()
                                  .setup(schoolName, context)
                            },
                          ))
                      .toList(),
                ),
              ],
            ),
          )),
    );
  }
}
