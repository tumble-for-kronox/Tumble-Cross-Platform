import 'package:flutter/material.dart';
import 'package:tumble/models/ui_models/week_model.dart';
import 'package:tumble/ui/home_page_widget/schedule_view_widgets/tumble_week_view/week_mapper.dart';
import 'package:tumble/ui/home_page_widget/schedule_view_widgets/tumble_week_view/week_number.dart';

class TumbleWeekPageContainer extends StatelessWidget {
  final Week week;
  final String scheduleId;

  const TumbleWeekPageContainer({
    Key? key,
    required this.week,
    required this.scheduleId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WeekMapper(week: week),
        WeekNumber(
          week: week,
        )
      ],
    );
  }
}
