import 'package:flutter/cupertino.dart';
import 'package:tumble/core/models/ui_models/week_model.dart';
import 'package:tumble/core/ui/main_app_widget/schedule_view_widgets/tumble_week_view/tumble_day_of_week_container.dart';

class WeekMapper extends StatelessWidget {
  final Week week;
  const WeekMapper({Key? key, required this.week}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: ListView(
          padding: const EdgeInsets.only(top: 20),
          children: week.days
              .map((day) => TumbleDayOfWeekContainer(
                    day: day,
                  ))
              .toList()),
    );
  }
}
