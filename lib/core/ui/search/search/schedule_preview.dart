import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/api/backend/response_types/runtime_error_type.dart';
import 'package:tumble/core/navigation/app_navigator.dart';
import 'package:tumble/core/ui/data/string_constants.dart';
import 'package:tumble/core/ui/schedule/dynamic_error_page.dart';
import 'package:tumble/core/ui/schedule/tumble_list_view/data/custom_alerts.dart';
import 'package:tumble/core/ui/schedule/tumble_list_view/data/to_top_button.dart';
import 'package:tumble/core/ui/search/cubit/search_page_cubit.dart';
import 'package:tumble/core/ui/search/search/preview_list_view_day_container.dart';
import 'package:tumble/core/ui/tumble_loading.dart';

typedef ToggleBookmark = Function(bool value);

class SchedulePreview extends StatefulWidget {
  final ToggleBookmark toggleBookmark;
  const SchedulePreview({Key? key, required this.toggleBookmark}) : super(key: key);

  @override
  State<SchedulePreview> createState() => _SchedulePreviewState();
}

/// Requires context from parent SearchPageCubit and MainAppNavigationCubit
class _SchedulePreviewState extends State<SchedulePreview> {
  @override
  Widget build(BuildContext context) {
    final AppNavigator navigator = BlocProvider.of<AppNavigator>(context);
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
                              Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  dayList[index].isoString.year.toString(),
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.onBackground.withOpacity(0.3),
                                    fontSize: 110,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 40),
                                child: PreviewListViewDayContainer(day: dayList[index]),
                              )
                            ],
                          );
                        }

                        return PreviewListViewDayContainer(day: dayList[index]);
                      }),
                ),
                AnimatedPositioned(
                  bottom: 30,
                  right: state.previewToTopButtonVisible! ? 35 : -60,
                  duration: const Duration(milliseconds: 200),
                  child: ToTopButton(scrollToTop: () => context.read<SearchPageCubit>().scrollToTop()),
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
