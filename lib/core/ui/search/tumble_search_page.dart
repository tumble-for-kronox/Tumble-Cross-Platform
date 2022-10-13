import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/ui/cubit/search_page_cubit.dart';
import 'package:tumble/core/ui/data/string_constants.dart';
import 'package:tumble/core/ui/schedule/dynamic_error_page.dart';
import 'package:tumble/core/ui/search/program_card.dart';
import 'package:tumble/core/ui/search/schedule_preview.dart';
import 'package:tumble/core/ui/search/searchbar_and_logo_container.dart';
import 'package:tumble/core/ui/tumble_loading.dart';

class TumbleSearchPage extends StatefulWidget {
  const TumbleSearchPage({Key? key}) : super(key: key);

  @override
  State<TumbleSearchPage> createState() => _TumbleSearchPageState();
}

class _TumbleSearchPageState extends State<TumbleSearchPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchPageCubit, SearchPageState>(
      builder: (context, state) {
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
                          child: Builder(builder: (context) {
                            switch (state.searchPageStatus) {
                              case SearchPageStatus.FOUND:
                                return Container(
                                  padding: const EdgeInsets.only(top: 70),
                                  child: SingleChildScrollView(
                                    physics: const ScrollPhysics(),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.only(left: 25, bottom: 10),
                                          child: Text(
                                            S.searchPage.results(state.programList!.length),
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Theme.of(context).colorScheme.onSurface.withOpacity(.8)),
                                          ),
                                        ),
                                        Divider(
                                          indent: 10,
                                          endIndent: 10,
                                          height: 10,
                                          color: Theme.of(context).colorScheme.onBackground,
                                        ),
                                        ListView.builder(
                                          physics: const NeverScrollableScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemCount: state.programList!.length,
                                          itemBuilder: (BuildContext context, int index) => ProgramCard(
                                              programName: state.programList![index].title,
                                              programSubtitle: state.programList![index].subtitle,
                                              schoolName: context.read<SearchPageCubit>().defaultSchool,
                                              onTap: () async {
                                                context.read<SearchPageCubit>().setPreviewLoading();
                                                context.read<SearchPageCubit>().displayPreview();
                                                await BlocProvider.of<SearchPageCubit>(context)
                                                    .openSchedule(state.programList![index].id);
                                              }),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              case SearchPageStatus.LOADING:
                                return const TumbleLoading();
                              case SearchPageStatus.ERROR:
                                return Container(
                                  padding: const EdgeInsets.only(top: 40, left: 7),
                                  child: DynamicErrorPage(
                                    toSearch: false,
                                    errorType: state.errorMessage!,
                                    description: state.errorDescription,
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
                                return const SchedulePreview();
                            }
                          }))),
                ],
              ),
            ),
            BlocProvider.value(
              value: BlocProvider.of<SearchPageCubit>(context),
              child: const SearchBarAndLogoContainer(),
            ),
          ],
        );
      },
    );
  }
}
