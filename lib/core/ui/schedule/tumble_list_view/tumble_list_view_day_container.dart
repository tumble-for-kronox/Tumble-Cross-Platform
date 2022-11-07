import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/models/backend_models/schedule_model.dart';
import 'package:tumble/core/ui/cubit/schedule_view_cubit.dart';
import 'package:tumble/core/ui/schedule/event_modal.dart';
import 'package:tumble/core/ui/schedule/event_options.dart';
import 'package:tumble/core/ui/schedule/tumble_list_view/tumble_list_view_schedule_card.dart';

class TumbleListViewDayContainer extends StatefulWidget {
  final Day day;
  const TumbleListViewDayContainer({Key? key, required this.day}) : super(key: key);

  @override
  State<TumbleListViewDayContainer> createState() => _TumbleListViewDayContainerState();
}

class _TumbleListViewDayContainerState extends State<TumbleListViewDayContainer> {
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
                  "${DateFormat.EEEE(Localizations.localeOf(context).languageCode).format(widget.day.isoString).capitalize()} ${DateFormat("d/M", Localizations.localeOf(context).languageCode).format(widget.day.isoString)}",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground, fontSize: 18, fontWeight: FontWeight.w400)),
              Expanded(
                  child: Divider(
                color: Theme.of(context).colorScheme.onBackground,
                indent: 10,
                endIndent: 10,
                thickness: 1,
              ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 2),
            child: StreamBuilder<Map<String, int>>(
                stream: context.read<ScheduleViewCubit>().courseColorStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: widget.day.events
                          .map((event) => GestureDetector(
                                onLongPress: () => EventOptions.showEventOptions(context, event),
                                child: ScheduleCard(
                                    event: event,
                                    color: event.isSpecial ? Colors.redAccent : Color(snapshot.data![event.course.id]!),
                                    onTap: () => TumbleEventModal.showBookmarkEventModal(
                                        context, event, Color(snapshot.data![event.course.id]!))),
                              ))
                          .toList(),
                    );
                  }
                  return Container();
                }),
          )
        ],
      ),
    );
  }
}
