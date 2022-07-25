import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

import 'package:tumble/models/api_models/schedule_model.dart';
import 'package:tumble/ui/home_page_widget/schedule_view_widgets/event_details/event_details_description_container.dart';
import 'package:tumble/ui/home_page_widget/schedule_view_widgets/event_details/event_details_teacher_and_location_container.dart';

class EventDetailsPage extends StatelessWidget {
  final Event event;

  const EventDetailsPage({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        foregroundColor: Theme.of(context).colorScheme.onBackground,
        shadowColor: Colors.transparent,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            // Column for weekday + time and date
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      DateFormat("EEEE").format(event.timeStart).toUpperCase(),
                      style: const TextStyle(fontSize: 75),
                    ),
                  ),
                  // Row for time and date
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Column for time stamp
                      Column(
                        children: [
                          Text(
                            DateFormat("HH:mm").format(event.timeStart),
                            style: const TextStyle(
                                fontSize: 29, fontWeight: FontWeight.w300),
                          ),
                          Text(
                            DateFormat("HH:mm").format(event.timeEnd),
                            style: const TextStyle(
                                fontSize: 29, fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                      Text(
                        "${DateFormat("MMM").format(event.timeStart).toUpperCase()} ${DateFormat("dd").format(event.timeStart)}",
                        style: const TextStyle(fontSize: 75),
                      )
                    ],
                  )
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Image(
                    image:
                        const AssetImage("assets/images/detailsSplitter.png"),
                    color: Colors.blue.withOpacity(0.35),
                  ),
                ),
                Expanded(
                  child: Transform.rotate(
                    angle: pi / 180 * 180,
                    child: Image(
                        image: const AssetImage(
                            "assets/images/detailsSplitter.png"),
                        color: Colors.blue.withOpacity(0.35)),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Theme.of(context).colorScheme.surface,
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EventDetailsDescriptionContainer(
                      event: event,
                    ),
                    EventDetailsTeacherAndLocationContainer(event: event)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
