import 'package:flutter/material.dart';
import 'package:tumble/models/api_models/schedule_model.dart';

class EventDetailsDescriptionContainer extends StatelessWidget {
  final Event event;
  const EventDetailsDescriptionContainer({Key? key, required this.event})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              event.course.id,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 24,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              event.title,
              maxLines: 10,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 20,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
