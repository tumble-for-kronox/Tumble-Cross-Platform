import 'package:flutter/cupertino.dart';
import 'package:tumble/core/models/api_models/schedule_model.dart';
import 'package:tumble/core/ui/data/groups/scaffold_message_types.dart';
import 'package:tumble/core/ui/app_switch/cubit/app_switch_cubit.dart';
import 'package:tumble/core/ui/scaffold_message.dart';
import 'package:tumble/core/ui/schedule/tumble_list_view/tumble_list_view_day_container.dart';
import 'package:tumble/core/ui/schedule/tumble_week_view/tumble_day_of_week_divider.dart';
import 'package:tumble/core/ui/schedule/tumble_week_view/tumble_empty_week_event_tile.dart';
import 'package:tumble/core/ui/schedule/tumble_week_view/tumble_week_event_tile.dart';

import '../event_options.dart';

class TumbleDayOfWeekContainer extends StatelessWidget {
  final Day day;
  final AppSwitchCubit cubit;
  const TumbleDayOfWeekContainer({Key? key, required this.day, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return day.events.isEmpty
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
                        onLongPress: () => EventOptions.showEventOptions(context, event, cubit),
                        child: TumbleWeekEventTile(event: event, mainAppCubit: cubit)))
                    .toList(),
          );
  }
}
