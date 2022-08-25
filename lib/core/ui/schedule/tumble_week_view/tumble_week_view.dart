import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tumble/core/api/apiservices/runtime_error_type.dart';
import 'package:tumble/core/navigation/app_navigator.dart';
import 'package:tumble/core/ui/bottom_nav_bar/cubit/bottom_nav_cubit.dart';
import 'package:tumble/core/ui/bottom_nav_bar/data/nav_bar_items.dart';
import 'package:tumble/core/ui/main_app/cubit/main_app_cubit.dart';
import 'package:tumble/core/ui/schedule/no_schedule.dart';
import 'package:tumble/core/ui/schedule/tumble_list_view/data/cupertino_alerts.dart';
import 'package:tumble/core/ui/schedule/tumble_week_view/week_list_view.dart';

class TumbleWeekView extends StatefulWidget {
  const TumbleWeekView({Key? key}) : super(key: key);

  @override
  State<TumbleWeekView> createState() => _TumbleWeekViewState();
}

class _TumbleWeekViewState extends State<TumbleWeekView> {
  @override
  Widget build(BuildContext context) {
    final AppNavigator navigator = BlocProvider.of<AppNavigator>(context);
    return BlocBuilder<MainAppCubit, MainAppState>(
      builder: (context, state) {
        switch (state.status) {
          case MainAppStatus.INITIAL:
            return NoScheduleAvailable(
              errorType: RuntimeErrorType.noCachedSchedule(),
              cupertinoAlertDialog: CustomCupertinoAlerts.noBookMarkedSchedules(
                  context, () => context.read<MainAppNavigationCubit>().getNavBarItem(NavbarItem.SEARCH), navigator),
            );
          case MainAppStatus.LOADING:
            return SpinKitThreeBounce(color: Theme.of(context).colorScheme.primary);
          case MainAppStatus.SCHEDULE_SELECTED:
            return Stack(children: [
              SizedBox(
                  child: PageView.builder(
                      itemCount: state.listOfWeeks!.length,
                      itemBuilder: (context, index) {
                        return state.listOfWeeks!
                            .map((e) => TumbleWeekPageContainer(
                                  scheduleId: state.currentScheduleId!,
                                  week: e,
                                  cubit: BlocProvider.of<MainAppCubit>(context),
                                ))
                            .toList()[index];
                      }))
            ]);
          case MainAppStatus.FETCH_ERROR:
            return NoScheduleAvailable(
              errorType: state.message!,
              cupertinoAlertDialog: CustomCupertinoAlerts.fetchError(
                  context, () => context.read<MainAppNavigationCubit>().getNavBarItem(NavbarItem.SEARCH), navigator),
            );
          case MainAppStatus.EMPTY_SCHEDULE:
            return NoScheduleAvailable(
              errorType: RuntimeErrorType.emptyScheduleError(),
              cupertinoAlertDialog: CustomCupertinoAlerts.scheduleContainsNoViews(
                  context, () => context.read<MainAppNavigationCubit>().getNavBarItem(NavbarItem.SEARCH), navigator),
            );
        }
      },
    );
  }
}
