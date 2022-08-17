import 'package:flutter/material.dart';
import 'package:tumble/core/models/api_models/upcoming_user_event_model.dart';

class UpcomingEventCard extends StatelessWidget {
  final UpcomingUserEventModel event;

  const UpcomingEventCard({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(event.title),
        Text(event.firstSignupDate.toString()),
      ],
    );
  }
}
