import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tumble/core/api/apiservices/fetch_response.dart';
import 'package:tumble/core/navigation/app_navigator.dart';
import 'package:tumble/core/ui/bottom_nav_bar/cubit/bottom_nav_cubit.dart';
import 'package:tumble/core/ui/bottom_nav_bar/data/nav_bar_items.dart';
import 'package:tumble/core/ui/main_app/cubit/main_app_cubit.dart';
import 'package:tumble/core/ui/schedule/no_schedule.dart';
import 'package:tumble/core/ui/schedule/tumble_list_view/data/cupertino_alerts.dart';
import 'package:tumble/core/ui/schedule/tumble_list_view/data/to_top_button.dart';
import 'tumble_list_view_day_container.dart';

class TumbleListView extends StatelessWidget {
  const TumbleListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppNavigator navigator = BlocProvider.of<AppNavigator>(context);
    return BlocBuilder<MainAppCubit, MainAppState>(
      builder: (context, state) {
        switch (state.status) {
          case MainAppStatus.INITIAL:
            return NoScheduleAvailable(
              errorType: 'No bookmarked schedules',
              cupertinoAlertDialog: CustomCupertinoAlerts.noBookMarkedSchedules(
                  context,
                  () => context
                      .read<MainAppNavigationCubit>()
                      .getNavBarItem(NavbarItem.SEARCH),
                  navigator),
            );
          case MainAppStatus.LOADING:
            return SpinKitThreeBounce(
                color: Theme.of(context).colorScheme.primary);
          case MainAppStatus.SCHEDULE_SELECTED:
            return Stack(
              children: [
                RefreshIndicator(
                  onRefresh: () async {
                    context.read<MainAppCubit>().setLoading();
                    await context
                        .read<MainAppCubit>()
                        .fetchNewSchedule(state.currentScheduleId!);
                  },
                  child: SingleChildScrollView(
                    controller: context.read<MainAppCubit>().controller,
                    child: Column(
                        children: state.listOfDays!
                            .where((day) => day.events.isNotEmpty)
                            .map((day) => TumbleListViewDayContainer(
                                  day: day,
                                ))
                            .toList()),
                  ),
                ),
                AnimatedPositioned(
                  bottom: 30,
                  right: state.listViewToTopButtonVisible ? 35 : -60,
                  duration: const Duration(milliseconds: 200),
                  child: ToTopButton(
                      scrollToTop: () =>
                          context.read<MainAppCubit>().scrollToTop()),
                ),
              ],
            );
          case MainAppStatus.FETCH_ERROR:
            return NoScheduleAvailable(
              errorType: state.message!,
              cupertinoAlertDialog: CustomCupertinoAlerts.fetchError(
                  context,
                  () => context
                      .read<MainAppNavigationCubit>()
                      .getNavBarItem(NavbarItem.SEARCH),
                  navigator),
            );

          case MainAppStatus.EMPTY_SCHEDULE:
            return NoScheduleAvailable(
              errorType: FetchResponse.emptyScheduleError,
              cupertinoAlertDialog:
                  CustomCupertinoAlerts.scheduleContainsNoViews(
                      context,
                      () => context
                          .read<MainAppNavigationCubit>()
                          .getNavBarItem(NavbarItem.SEARCH),
                      navigator),
            );
        }
      },
    );
  }
}
