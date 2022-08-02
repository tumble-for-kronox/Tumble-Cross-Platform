import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/models/api_models/schedule_model.dart';
import 'package:tumble/core/ui/main_app_widget/schedule_view_widgets/tumble_list_view/tumble_list_view_schedule_card_ribbon.dart';

typedef SetDefaultSchedule = void Function(String id);

class TumbleEventModal extends StatelessWidget {
  final Event event;
  final Color color;
  const TumbleEventModal({Key? key, required this.event, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locations = event.locations;
    return SizedBox(
      height: MediaQuery.of(context).size.height - 300,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: MediaQuery.of(context).size.height - 300,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: SingleChildScrollView(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.secondary),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          right: 0, left: 0, top: 5, bottom: 5),
                      child: Text(
                        event.title.length < 40
                            ? event.title.capitalize()
                            : '${event.title.substring(0, 40).capitalize()}..',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Date',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondary
                                    .withOpacity(.8),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(
                                  CupertinoIcons.calendar,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${DateFormat.d().format(event.timeStart)}/${DateFormat.M().format(event.timeStart)} ${DateFormat.y().format(event.timeStart)}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      overflow: TextOverflow.ellipsis,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground),
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Time',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondary
                                    .withOpacity(.8),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(
                                  CupertinoIcons.clock,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${DateFormat.Hm().format(event.timeStart)} - ${DateFormat.Hm().format(event.timeEnd)}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      overflow: TextOverflow.ellipsis,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground),
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Location',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondary
                                    .withOpacity(.8),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(
                                  CupertinoIcons.location,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  locations.isNotEmpty
                                      ? locations
                                          .map((location) => location.id)
                                          .join(', ')
                                      : 'No available locations for event',
                                  style: TextStyle(
                                      fontSize: 16,
                                      overflow: TextOverflow.ellipsis,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground),
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Course',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondary
                                    .withOpacity(.8),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(
                                  CupertinoIcons.book,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  event.course.englishName.length < 38
                                      ? event.course.englishName
                                      : '${event.course.englishName.substring(0, 38)}..',
                                  style: TextStyle(
                                      fontSize: 16,
                                      overflow: TextOverflow.ellipsis,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground),
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Teachers',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondary
                                    .withOpacity(.8),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(
                                  CupertinoIcons.person,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: Text(
                                    event.teachers
                                        .map((teacher) =>
                                            '${teacher.firstName} ${teacher.lastName}')
                                        .join(', '),
                                    style: TextStyle(
                                        fontSize: 16,
                                        overflow: TextOverflow.ellipsis,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          ScheduleCardRibbon(color: color)
        ],
      ),
    );
  }
}
