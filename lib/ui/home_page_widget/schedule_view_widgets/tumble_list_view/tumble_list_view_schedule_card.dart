import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tumble/models/api_models/schedule_model.dart';
import 'package:tumble/ui/home_page_widget/schedule_view_widgets/tumble_list_view/tumble_list_view_schedule_card_location_container.dart';
import 'package:tumble/ui/home_page_widget/schedule_view_widgets/tumble_list_view/tumble_list_view_schedule_card_ribbon.dart';
import 'package:tumble/ui/home_page_widget/schedule_view_widgets/tumble_list_view/tumble_list_view_schedule_card_time_stamp.dart';

class ScheduleCard extends StatelessWidget {
  final String title;
  final Course course;
  final List<Teacher> teachers;
  final List<Location> locations;
  final String color;
  final DateTime timeStart;
  final DateTime timeEnd;
  final VoidCallback onTap;

  const ScheduleCard({
    Key? key,
    required this.title,
    required this.course,
    required this.teachers,
    required this.locations,
    required this.color,
    required this.timeStart,
    required this.timeEnd,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 5),
        child: Stack(
          children: [
            Container(
              height: 150,
              width: double.infinity,
              margin: const EdgeInsets.only(top: 9, left: 20, right: 20),
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 1,
                        offset: Offset(0, 1))
                  ]),
              child: MaterialButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: onTap,
                  child: Container(
                      padding: const EdgeInsets.only(left: 10, top: 15),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FractionallySizedBox(
                            widthFactor: 0.85,
                            alignment: Alignment.topLeft,
                            child: Text(title,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 19,
                                  fontWeight: FontWeight.w400,
                                )),
                          ),
                          Expanded(
                            child: Stack(
                              children: [
                                Container(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(course.englishName,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300,
                                        ))),
                                Flexible(
                                  child: Row(
                                    children: [
                                      ScheduleCardLocationContainer(
                                          locations: locations),
                                      ScheduleCardTimeStamp(
                                          timeStart: timeStart,
                                          timeEnd: timeEnd)
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ))),
            ),
            ScheduleCardRibbon(color: color)
          ],
        ));
  }
}
