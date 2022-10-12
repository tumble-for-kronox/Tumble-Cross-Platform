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
            return DynamicErrorPage(
              toSearch: true,
              errorType: RuntimeErrorType.noCachedSchedule(),
              description: S.popUps.scheduleHelpFirstLine(),
            );
          case AppScheduleViewStatus.LOADING:
            return const TumbleLoading();
          case AppScheduleViewStatus.POPULATED_VIEW:
            return Stack(children: [
              SizedBox(
                  child: PageView.builder(
                      itemCount: state.listOfWeeks!.length,
                      itemBuilder: (context, index) {
                        int currentYear = 0;

                        return state.listOfWeeks!.map(
                          (week) {
                            if (week.days.first.isoString.year != currentYear) {
                              currentYear = week.days.first.isoString.year;
                              return Stack(
                                children: [
                                  Text(currentYear.toString(),
                                      style: TextStyle(
                                        color: Theme.of(context).colorScheme.onBackground.withOpacity(0.3),
                                        fontSize: 110,
                                        fontWeight: FontWeight.w600,
                                      )),
                                  TumbleWeekPageContainer(week: week, cubit: BlocProvider.of<AppSwitchCubit>(context))
                                ],
                              );
                            }

                            return TumbleWeekPageContainer(week: week, cubit: BlocProvider.of<AppSwitchCubit>(context));
                          },
                        ).toList()[index];
                      }))
            ]);
          case AppScheduleViewStatus.FETCH_ERROR:
            return DynamicErrorPage(
                toSearch: false, errorType: state.message!, description: S.popUps.scheduleFetchError());
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
