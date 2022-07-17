import 'package:flutter/cupertino.dart';
import 'package:tumble/models/ui_models/week_model.dart';
import 'package:tumble/ui/home_page_widget/schedule_view_widgets/tumble_week_view/tumble_day_of_week_container.dart';

class WeekMapper extends StatelessWidget {
  final Week week;
  const WeekMapper({Key? key, required this.week}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        children:
            week.days.map((e) => const TumbleDayOfWeekContainer()).toList());
  }
}
