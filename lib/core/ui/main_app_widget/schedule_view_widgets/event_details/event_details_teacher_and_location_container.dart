import 'package:flutter/material.dart';
import 'package:tumble/core/models/api_models/schedule_model.dart';

class EventDetailsTeacherAndLocationContainer extends StatelessWidget {
  final Event event;
  const EventDetailsTeacherAndLocationContainer({Key? key, required this.event})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
                child: Column(
                    children: event.locations
                        .map((location) => Text(
                              location.name,
                              softWrap: true,
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                  fontSize: 21,
                                  fontWeight: FontWeight.w100),
                            ))
                        .toList())),
            Expanded(
              child: Column(
                children: event.teachers
                    .map(
                      (teacher) => Text(
                        teacher.firstName,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 21,
                            fontWeight: FontWeight.w100),
                      ),
                    )
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
