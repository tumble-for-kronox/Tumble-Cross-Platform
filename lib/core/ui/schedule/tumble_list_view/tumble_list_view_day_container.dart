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
  const TumbleListViewDayContainer({super.key, required this.day});

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
                      color: Theme.of(context).colorScheme.onSurface, fontSize: 18, fontWeight: FontWeight.w400)),
              Expanded(
                  child: Divider(
                color: Theme.of(context).colorScheme.onSurface,
                indent: 10,
                endIndent: 10,
                thickness: 1,
              ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 2),
            child: Column(
              children: widget.day.events
                  .map((event) => GestureDetector(
                        onLongPress: () => EventOptions.showEventOptions(context, event),
                        child: ScheduleCard(
                            event: event,
                            color: event.isSpecial
                                ? Colors.redAccent
                                : Color(context.read<ScheduleViewCubit>().state.courseColors![event.course.id]!),
                            onTap: () => TumbleEventModal.showBookmarkEventModal(context, event,
                                Color(context.read<ScheduleViewCubit>().state.courseColors![event.course.id]!))),
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
