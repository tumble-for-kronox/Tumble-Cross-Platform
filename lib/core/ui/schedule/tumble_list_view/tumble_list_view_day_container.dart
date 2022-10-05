import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/models/api_models/schedule_model.dart';
import 'package:tumble/core/ui/app_switch/cubit/app_switch_cubit.dart';
import 'package:tumble/core/ui/schedule/event_modal.dart';
import 'package:tumble/core/ui/schedule/event_options.dart';
import 'package:tumble/core/ui/schedule/tumble_list_view/tumble_list_view_schedule_card.dart';

class TumbleListViewDayContainer extends StatelessWidget {
  final Day day;
  final AppSwitchCubit mainAppCubit;
  const TumbleListViewDayContainer({Key? key, required this.day, required this.mainAppCubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 20),
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                  "${DateFormat.EEEE(Localizations.localeOf(context).languageCode).format(day.isoString).capitalize()} ${DateFormat("d/M", Localizations.localeOf(context).languageCode).format(day.isoString)}",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground, fontSize: 17, fontWeight: FontWeight.w400)),
              Expanded(
                  child: Divider(
                color: Theme.of(context).colorScheme.onBackground,
                indent: 6,
                thickness: 1,
              ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 2),
            child: Column(
              children: day.events
                  .map((event) => GestureDetector(
                        onLongPress: () => EventOptions.showEventOptions(context, event, mainAppCubit),
                        child: ScheduleCard(
                            event: event,
                            color: event.isSpecial ? Colors.redAccent : mainAppCubit.getColorForCourse(event),
                            onTap: () => TumbleEventModal.showBookmarkEventModal(
                                context, event, mainAppCubit.getColorForCourse(event), mainAppCubit)),
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
