import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/shared/preference_types.dart';
import 'package:tumble/startup/get_it_instances.dart';
<<<<<<< HEAD:lib/ui/main_app_widget/search_page_widgets/search/tumble_search_page.dart
import 'package:tumble/theme/data/colors.dart';
=======
>>>>>>> 3c9afeb64288e6b42efb734cf65b646cd022907a:lib/ui/main_app_widget/search_page_widgets/search/schedule_search_page.dart
import 'package:tumble/ui/main_app_widget/cubit/main_app_cubit.dart';
import 'package:tumble/ui/main_app_widget/main_app.dart';
import 'package:tumble/theme/data/colors.dart';
import 'package:tumble/ui/main_app_widget/main_app_bottom_nav_bar/cubit/bottom_nav_cubit.dart';
import 'package:tumble/ui/main_app_widget/main_app_bottom_nav_bar/data/nav_bar_items.dart';
import 'package:tumble/ui/main_app_widget/search_page_widgets/search/program_card.dart';
import 'package:tumble/ui/main_app_widget/search_page_widgets/search/search_error_message.dart';
import 'package:tumble/ui/main_app_widget/search_page_widgets/search_bar_widget/searchbar_and_logo_container.dart';

import '../cubit/search_page_cubit.dart';

class TumbleSearchPage extends StatefulWidget {
  const TumbleSearchPage({Key? key}) : super(key: key);

  @override
  State<TumbleSearchPage> createState() => _TumbleSearchPageState();
}

class _TumbleSearchPageState extends State<TumbleSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top + 50),
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: BlocBuilder<SearchPageCubit, SearchPageState>(
                      builder: (context, state) {
                        if (state is SearchPageLoading) {
                          return const SpinKitThreeBounce(
                              color: CustomColors.orangePrimary);
                        }
                        if (state is SearchPageFoundSchedules) {
                          return ListView(
                            padding: const EdgeInsets.only(top: 70),
                            children: state.programList
                                .map((program) => ProgramCard(
                                    programName: program.title,
                                    programId: program.id,
                                    onTap: () async {
                                      context.read<MainAppCubit>().setLoading();
                                      context.read<MainAppNavigationCubit>().getNavBarItem(NavbarItem.LIST);

                                      await context.read<MainAppCubit>().fetchNewSchedule(program.id);
                                    }))
                                .toList(),
                          );
                        }
                        if (state is SearchPageNoSchedules) {
                          return SearchErrorMessage(
                            errorType: state.errorType,
                          );
                        }
                        return Container();
                      },
                    )),
              )
            ],
          ),
        ),
        const SearchBarAndLogoContainer(),
      ],
    );
  }
}
