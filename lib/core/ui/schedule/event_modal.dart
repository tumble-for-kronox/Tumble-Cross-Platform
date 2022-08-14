import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/models/api_models/schedule_model.dart';
import 'package:tumble/core/ui/schedule/modal_info_row.dart';
import 'package:tumble/core/ui/schedule/tumble_list_view/tumble_list_view_schedule_card_ribbon.dart';

typedef SetDefaultSchedule = void Function(String id);

class TumbleEventModal extends StatelessWidget {
  final Event event;
  final Color color;
  const TumbleEventModal({Key? key, required this.event, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locations = event.locations;
    return SizedBox(
      height: MediaQuery.of(context).size.height - 280,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: MediaQuery.of(context).size.height - 280,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(right: 0, left: 0, top: 5, bottom: 10),
                    child: Text(
                      event.title.length < 40
                          ? event.title.capitalize()
                          : '${event.title.substring(0, 40).capitalize()}..',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 32, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onBackground),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ModalInfoRow(
                        title: 'Date',
                        icon: const Icon(CupertinoIcons.calendar),
                        subtitle:
                            '${DateFormat.d().format(event.from)} ${DateFormat('MMMM').format(event.from)} ${DateFormat.y().format(event.from)}',
                      ),
                      const SizedBox(height: 25),
                      ModalInfoRow(
                        title: 'Time',
                        icon: const Icon(CupertinoIcons.clock),
                        subtitle: '${DateFormat.Hm().format(event.to)} - ${DateFormat.Hm().format(event.to)}',
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      ModalInfoRow(
                        title: 'Location',
                        icon: const Icon(CupertinoIcons.location),
                        locations: locations,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      ModalInfoRow(
                        title: 'Course',
                        icon: const Icon(CupertinoIcons.book),
                        subtitle: event.course.englishName,
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      ModalInfoRow(
                        title: 'Teachers',
                        icon: const Icon(CupertinoIcons.person_2),
                        teachers: event.teachers,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          ScheduleCardRibbon(color: color)
        ],
      ),
    );
  }
}
