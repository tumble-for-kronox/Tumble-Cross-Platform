import 'package:flutter/material.dart';
import 'package:tumble/core/models/ui_models/week_model.dart';
import 'package:tumble/core/ui/app_switch/cubit/app_switch_cubit.dart';
import 'package:tumble/core/ui/schedule/tumble_week_view/week_mapper.dart';
import 'package:tumble/core/ui/schedule/tumble_week_view/week_number.dart';

class TumbleWeekPageContainer extends StatelessWidget {
  final Week week;
  final AppSwitchCubit cubit;

  const TumbleWeekPageContainer(
      {Key? key, required this.week, required this.cubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WeekMapper(
          week: week,
          cubit: cubit,
        ),
        WeekNumber(
          week: week,
        )
      ],
    );
  }
}
