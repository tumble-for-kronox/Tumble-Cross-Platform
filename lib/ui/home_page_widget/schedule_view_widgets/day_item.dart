
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tumble/models/api_models/schedule_model.dart';
import 'package:tumble/ui/home_page_widget/schedule_view_widgets/schedule_card.dart';

class DayItem extends StatelessWidget {
  final Day day;
  final VoidCallback onTap;
  const DayItem({Key? key, required this.day, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 28),
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              Text("${day.dayOfWeek} ${day.date}",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 17,
                      fontWeight: FontWeight.w400)),
              Expanded(
                  child: Divider(
                    color: Theme.of(context).colorScheme.onBackground,
                    indent: 6,
                    thickness: 1,
                  ))
            ],
          ),
          Column(
            children: day.events
                .map((event) => ScheduleCard(
                title: event.title,
                course: event.course.name,
                teacher: event.teacher,
                location: event.location,
                color: event.course.color,
                timeStart: event.timeStart,
                timeEnd: event.timeEnd,
                onTap: onTap))
                .toList(),
          )
        ],
      ),
    );
  }
}