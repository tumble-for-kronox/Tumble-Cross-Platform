import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/api/backend/response_types/runtime_error_type.dart';
import 'package:tumble/core/navigation/app_navigator.dart';
import 'package:tumble/core/ui/bottom_nav_bar/cubit/bottom_nav_cubit.dart';
import 'package:tumble/core/ui/bottom_nav_bar/data/nav_bar_items.dart';
import 'package:tumble/core/ui/app_switch/cubit/app_switch_cubit.dart';
import 'package:tumble/core/ui/schedule/no_schedule.dart';
import 'package:tumble/core/ui/schedule/tumble_list_view/data/custom_alerts.dart';
import 'package:tumble/core/ui/schedule/tumble_week_view/week_list_view.dart';
import 'package:tumble/core/ui/tumble_loading.dart';

class TumbleWeekView extends StatefulWidget {
  const TumbleWeekView({Key? key}) : super(key: key);

  @override
  State<TumbleWeekView> createState() => _TumbleWeekViewState();
}

class _TumbleWeekViewState extends State<TumbleWeekView> {
  @override
  Widget build(BuildContext context) {
    final AppNavigator navigator = BlocProvider.of<AppNavigator>(context);
    return BlocBuilder<AppSwitchCubit, AppSwitchState>(
      builder: (context, state) {
        switch (state.status) {
          case AppScheduleViewStatus.INITIAL:
            return NoScheduleAvailable(
              errorType: RuntimeErrorType.noCachedSchedule(),
              cupertinoAlertDialog: CustomAlertDialog.noBookMarkedSchedules(
                  context, () => context.read<MainAppNavigationCubit>().getNavBarItem(NavbarItem.SEARCH), navigator),
            );
          case AppScheduleViewStatus.LOADING:
            return const TumbleLoading();
          case AppScheduleViewStatus.POPULATED_VIEW:
            return Stack(children: [
              SizedBox(
                  child: PageView.builder(
                      itemCount: state.listOfWeeks!.length,
                      itemBuilder: (context, index) {
                        return state.listOfWeeks!
                            .map((e) => TumbleWeekPageContainer(
                                  week: e,
                                  cubit: BlocProvider.of<AppSwitchCubit>(context),
                                ))
                            .toList()[index];
                      }))
            ]);
          case AppScheduleViewStatus.FETCH_ERROR:
            return NoScheduleAvailable(
              errorType: state.message!,
              cupertinoAlertDialog: CustomAlertDialog.scheduleCacheFetchError(
                  context, () => context.read<MainAppNavigationCubit>().getNavBarItem(NavbarItem.SEARCH), navigator),
            );
          case AppScheduleViewStatus.EMPTY_SCHEDULE:
            return NoScheduleAvailable(
              errorType: RuntimeErrorType.emptyScheduleError(),
              cupertinoAlertDialog: CustomAlertDialog.previewContainsNoViews(
                  context, () => context.read<MainAppNavigationCubit>().getNavBarItem(NavbarItem.SEARCH), navigator),
            );
          case AppScheduleViewStatus.NO_VIEW:
            return NoScheduleAvailable(
              errorType: RuntimeErrorType.noBookmarks(),
              cupertinoAlertDialog: CustomAlertDialog.noBookMarkedSchedules(
                  context, () => context.read<MainAppNavigationCubit>().getNavBarItem(NavbarItem.SEARCH), navigator),
            );
        }
      },
    );
  }
}
