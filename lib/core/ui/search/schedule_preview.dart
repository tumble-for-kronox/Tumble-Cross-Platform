import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/api/backend/response_types/runtime_error_type.dart';
import 'package:tumble/core/ui/cubit/search_page_cubit.dart';
import 'package:tumble/core/ui/data/string_constants.dart';
import 'package:tumble/core/ui/scaffold_message.dart';
import 'package:tumble/core/ui/schedule/dynamic_error_page.dart';
import 'package:tumble/core/ui/schedule/tumble_list_view/data/to_top_button.dart';
import 'package:tumble/core/ui/search/preview_list_view_day_container.dart';
import 'package:tumble/core/ui/tumble_loading.dart';

typedef ToggleBookmark = Function(bool value);

class SchedulePreview extends StatefulWidget {
  const SchedulePreview({Key? key}) : super(key: key);

  @override
  State<SchedulePreview> createState() => _SchedulePreviewState();
}

/// Requires context from parent SearchPageCubit and MainAppNavigationCubit
class _SchedulePreviewState extends State<SchedulePreview> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchPageCubit, SearchPageState>(
      builder: (context, state) {
        switch (state.previewFetchStatus) {
          case PreviewFetchStatus.LOADING:
            return const TumbleLoading();
          case PreviewFetchStatus.FETCHED_SCHEDULE:
          case PreviewFetchStatus.CACHED_SCHEDULE:
            final dayList = state.previewListOfDays!
                .where((day) =>
                    day.events.isNotEmpty && day.isoString.isAfter(DateTime.now().subtract(const Duration(days: 1))))
                .toList();
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: ListView.builder(
                      controller: context.read<SearchPageCubit>().controller,
                      itemCount: dayList.length,
                      itemBuilder: (context, index) {
                        if (index == 0 || dayList[index].isoString.year != dayList[index - 1].isoString.year) {
                          return Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                                alignment: Alignment.topRight,
                                child: Text(
                                  dayList[index].isoString.year.toString(),
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.onBackground,
                                    fontSize: 40,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(top: 40),
                                  child: PreviewListViewDayContainer(
                                    day: dayList[index],
                                    searchPageCubit: context.read<SearchPageCubit>(),
                                  ))
                            ],
                          );
                        }

                        return PreviewListViewDayContainer(
                            day: dayList[index], searchPageCubit: context.read<SearchPageCubit>());
                      }),
                ),
                AnimatedPositioned(
                  bottom: 30,
                  right: state.previewToTopButtonVisible! ? 35 : -60,
                  duration: const Duration(milliseconds: 200),
                  child: ToTopButton(scrollToTop: () => context.read<SearchPageCubit>().scrollToTop()),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 25, bottom: 25),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: !context.read<SearchPageCubit>().scheduleInBookmarks
                        ? ElevatedButton.icon(
                            onPressed: () {
                              context.read<SearchPageCubit>().bookmarkSchedule();
                              showScaffoldMessage(
                                  context, S.scaffoldMessages.addedBookmark(state.previewCurrentScheduleId!));
                            },
                            icon: const Icon(
                              CupertinoIcons.bookmark,
                              size: 23,
                            ),
                            label: Text(
                              S.searchPage.saveSchedule(),
                              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                            ))
                        : ElevatedButton.icon(
                            onPressed: () {
                              context.read<SearchPageCubit>().unBookmarkSchedule();
                              showScaffoldMessage(
                                  context, S.scaffoldMessages.removedBookmark(state.previewCurrentScheduleId!));
                            },
                            icon: const Icon(
                              CupertinoIcons.bookmark_fill,
                              size: 23,
                            ),
                            label: Text(
                              S.searchPage.scheduleIsSaved(),
                              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                            )),
                  ),
                ),
              ],
            );
          case PreviewFetchStatus.FETCH_ERROR:
            return Container(
              padding: const EdgeInsets.only(top: 40, left: 7),
              child: DynamicErrorPage(
                toSearch: false,
                errorType: RuntimeErrorType.scheduleFetchError(),
                description: S.popUps.scheduleFetchError(),
              ),
            );
          case PreviewFetchStatus.EMPTY_SCHEDULE:
            return Container(
              padding: const EdgeInsets.only(top: 40, left: 7),
              child: DynamicErrorPage(
                toSearch: false,
                errorType: RuntimeErrorType.emptyScheduleError(),
                description: S.popUps.scheduleIsEmptyBody(),
              ),
            );
          case PreviewFetchStatus.INITIAL:
            return Container();
        }
      },
    );
  }
}
