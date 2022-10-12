import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/models/backend_models/schedule_model.dart';
import 'package:tumble/core/ui/schedule/event_modal.dart';
import 'package:tumble/core/ui/schedule/tumble_list_view/tumble_list_view_schedule_card.dart';
import 'package:tumble/core/ui/search/cubit/search_page_cubit.dart';

class PreviewListViewDayContainer extends StatelessWidget {
  final Day day;
  const PreviewListViewDayContainer({Key? key, required this.day}) : super(key: key);

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
              Text("${day.name} ${day.date}",
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
                  .map((event) => ScheduleCard(
                      event: event,
                      color:
                          event.isSpecial ? Colors.redAccent : context.read<SearchPageCubit>().getColorForCourse(event),
                      onTap: () => TumbleEventModal.showPreviewEventModal(
                          context, event, context.read<SearchPageCubit>().getColorForCourse(event))))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
