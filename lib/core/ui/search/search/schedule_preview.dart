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
  final GlobalKey<AnimatedListState> _animatedListKey = GlobalKey();
  final List<PreviewListViewDayContainer> _listItems = [];

  void _buildItems(List<PreviewListViewDayContainer> fetchedList) {
    var future = Future(() {});
    for (var i = 0; i < fetchedList.length; i++) {
      future = future.then((_) {
        return Future.delayed(const Duration(milliseconds: 10), () {
          _listItems.add(fetchedList[i]);
          _animatedListKey.currentState?.insertItem(_listItems.length - 1, duration: const Duration(milliseconds: 300));
        });
      });
    }
  }

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
            _buildItems(context.read<SearchPageCubit>().getParsedPreviewDays());
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: AnimatedList(
                    key: _animatedListKey,
                    initialItemCount: _listItems.length,
                    itemBuilder: (BuildContext context, int index, Animation<double> animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position:
                              Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0)).animate(animation),
                          child: _listItems[index],
                        ),
                      );
                    },
                  ),
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
