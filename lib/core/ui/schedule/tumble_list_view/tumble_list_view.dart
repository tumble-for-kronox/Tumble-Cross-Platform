import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/api/backend/response_types/runtime_error_type.dart';
import 'package:tumble/core/navigation/app_navigator.dart';
import 'package:tumble/core/ui/bottom_nav_bar/cubit/bottom_nav_cubit.dart';
import 'package:tumble/core/ui/bottom_nav_bar/data/nav_bar_items.dart';
import 'package:tumble/core/ui/app_switch/cubit/app_switch_cubit.dart';
import 'package:tumble/core/ui/data/string_constants.dart';
import 'package:tumble/core/ui/schedule/dynamic_error_page.dart';
import 'package:tumble/core/ui/schedule/tumble_list_view/data/custom_alerts.dart';
import 'package:tumble/core/ui/schedule/tumble_list_view/data/to_top_button.dart';
import 'package:tumble/core/ui/tumble_loading.dart';
import 'tumble_list_view_day_container.dart';

class TumbleListView extends StatelessWidget {
  TumbleListView({Key? key}) : super(key: key);

  final GlobalKey<AnimatedListState> _animatedListKey = GlobalKey();
  List<TumbleListViewDayContainer> _listItems = [];

  void _buildItems(List<TumbleListViewDayContainer> fetchedList) {
    _listItems = [];
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
    return BlocBuilder<AppSwitchCubit, AppSwitchState>(
      builder: (context, state) {
        switch (state.status) {
          case AppScheduleViewStatus.INITIAL:
            return DynamicErrorPage(
              toSearch: true,
              description: S.popUps.scheduleHelpFirstLine(),
              errorType: RuntimeErrorType.noCachedSchedule(),
            );
          case AppScheduleViewStatus.LOADING:
            return const TumbleLoading();
          case AppScheduleViewStatus.POPULATED_VIEW:
            _buildItems(context.read<AppSwitchCubit>().getParsedDayList());
            return Stack(
              children: [
                RefreshIndicator(
                  onRefresh: () async {
                    context.read<AppSwitchCubit>().setLoading();
                    await context.read<AppSwitchCubit>().forceRefreshAll();
                  },
                  child: AnimatedList(
                    controller: context.read<AppSwitchCubit>().controller,
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
                  right: context.read<AppSwitchCubit>().toTopButtonVisible() ? 35 : -60,
                  duration: const Duration(milliseconds: 200),
                  child: ToTopButton(scrollToTop: () => context.read<AppSwitchCubit>().scrollToTop()),
                ),
              ],
            );
          case AppScheduleViewStatus.FETCH_ERROR:
            return DynamicErrorPage(
              toSearch: false,
              errorType: RuntimeErrorType.scheduleFetchError(),
              description: S.popUps.scheduleIsEmptyTitle(),
            );

          case AppScheduleViewStatus.EMPTY_SCHEDULE:
            return DynamicErrorPage(
              toSearch: false,
              errorType: RuntimeErrorType.emptyScheduleError(),
              description: S.popUps.scheduleIsEmptyBody(),
            );

          case AppScheduleViewStatus.NO_VIEW:
            return DynamicErrorPage(
              toSearch: true,
              errorType: RuntimeErrorType.noBookmarks(),
              description: S.popUps.scheduleHelpFirstLine(),
            );
        }
      },
    );
  }
}
