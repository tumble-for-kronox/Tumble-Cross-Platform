import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/models/backend_models/schedule_model.dart';
import 'package:tumble/core/ui/cubit/search_page_cubit.dart';
import 'package:tumble/core/ui/schedule/event_modal.dart';
import 'package:tumble/core/ui/schedule/tumble_list_view/tumble_list_view_schedule_card.dart';

class PreviewListViewDayContainer extends StatelessWidget {
  final Day day;
  final SearchPageCubit searchPageCubit;
  const PreviewListViewDayContainer({super.key, required this.day, required this.searchPageCubit});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 20),
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                  "${DateFormat.EEEE(Localizations.localeOf(context).languageCode).format(day.isoString).capitalize()} ${DateFormat("d/M", Localizations.localeOf(context).languageCode).format(day.isoString)}",
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
              children: day.events
                  .map((event) => ScheduleCard(
                      event: event,
                      color: event.isSpecial
                          ? Colors.redAccent
                          : Color(searchPageCubit.state.courseColors![event.course.id]!),
                      onTap: () => TumbleEventModal.showPreviewEventModal(
                          context, event, Color(searchPageCubit.state.courseColors![event.course.id]!))))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
