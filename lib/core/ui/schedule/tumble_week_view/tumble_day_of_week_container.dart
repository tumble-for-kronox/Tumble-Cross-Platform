import 'package:flutter/cupertino.dart';
import 'package:tumble/core/models/backend_models/schedule_model.dart';
import 'package:tumble/core/ui/schedule/tumble_week_view/tumble_day_of_week_divider.dart';
import 'package:tumble/core/ui/schedule/tumble_week_view/tumble_empty_week_event_tile.dart';
import 'package:tumble/core/ui/schedule/tumble_week_view/tumble_week_event_tile.dart';

import '../event_options.dart';

class TumbleDayOfWeekContainer extends StatelessWidget {
  final Day day;
  const TumbleDayOfWeekContainer({Key? key, required this.day}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      child: day.events.isEmpty
          ? Column(
              children: [
                DayOfWeekDivider(day: day),
                const TumbleEmptyWeekEventTile(),
              ],
            )
          : Column(
              children: <Widget>[DayOfWeekDivider(day: day)] +
                  day.events
                      .map((Event event) => GestureDetector(
                          onLongPress: () => EventOptions.showEventOptions(context, event),
                          child: TumbleWeekEventTile(event: event)))
                      .toList(),
            ),
    );
  }
}
