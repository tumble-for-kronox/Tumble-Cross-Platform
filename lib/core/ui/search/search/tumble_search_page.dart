import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/models/backend_models/program_model.dart';
import 'package:tumble/core/ui/bottom_nav_bar/cubit/bottom_nav_cubit.dart';
import 'package:tumble/core/ui/data/string_constants.dart';
import 'package:tumble/core/ui/init_cubit/init_cubit.dart';
import 'package:tumble/core/ui/schedule/dynamic_error_page.dart';
import 'package:tumble/core/ui/search/cubit/search_page_cubit.dart';
import 'package:tumble/core/ui/search/search/program_card.dart';
import 'package:tumble/core/ui/search/search/schedule_preview.dart';
import 'package:tumble/core/ui/search/search/search_error_message.dart';
import 'package:tumble/core/ui/search/search/searchbar_and_logo_container.dart';
import 'package:tumble/core/ui/tumble_loading.dart';

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
          margin: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top + 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: BlocBuilder<SearchPageCubit, SearchPageState>(
                      builder: (_, state) {
                        switch (state.searchPageStatus) {
                          case SearchPageStatus.FOUND:
                            return ListView(
                              padding: const EdgeInsets.only(top: 70),
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(left: 25, bottom: 10),
                                  child: Text(
                                    S.searchPage.results(state.programList!.length),
                                    style: TextStyle(
                                        fontSize: 15, color: Theme.of(context).colorScheme.onSurface.withOpacity(.8)),
                                  ),
                                ),
                                Divider(
                                  indent: 10,
                                  endIndent: 10,
                                  height: 10,
                                  color: Theme.of(context).colorScheme.onBackground,
                                ),
                                _buildProgramsList(state.programList!, context)
                              ],
                            );
                          case SearchPageStatus.LOADING:
                            return const TumbleLoading();
                          case SearchPageStatus.ERROR:
                            return Container(
                              padding: const EdgeInsets.only(top: 40, left: 7),
                              child: DynamicErrorPage(
                                toSearch: false,
                                errorType: state.errorMessage!,
                                description: S.popUps.missingProgramRequestDescription(),
                              ),
                            );
                          case SearchPageStatus.INITIAL:
                            return Container();
                          case SearchPageStatus.NO_SCHEDULES:
                            return Container(
                              padding: const EdgeInsets.only(top: 40),
                              child: DynamicErrorPage(
                                  toSearch: false,
                                  errorType: state.errorMessage!,
                                  description: S.popUps.scheduleIsEmptyBody()),
                            );
                          case SearchPageStatus.DISPLAY_PREVIEW:
                            return SchedulePreview(
                              toggleBookmark: (value) =>
                                  BlocProvider.of<MainAppNavigationCubit>(context).setPreviewToggle(),
                            );
                        }
                      },
                    )),
              )
            ],
          ),
        ),
        BlocProvider.value(
          value: BlocProvider.of<SearchPageCubit>(context),
          child: const SearchBarAndLogoContainer(),
        ),
      ],
    );
  }
}

_buildProgramsList(List<Item> programList, BuildContext context) => Column(
    children: programList
        .map((program) => ProgramCard(
            programName: program.title,
            programSubtitle: program.subtitle,
            schoolName: BlocProvider.of<InitCubit>(context).state.defaultSchool!,
            onTap: () async {
              context.read<SearchPageCubit>().setPreviewLoading();
              context.read<SearchPageCubit>().displayPreview();
              await BlocProvider.of<SearchPageCubit>(context).fetchNewSchedule(program.id);
            }))
        .toList());
