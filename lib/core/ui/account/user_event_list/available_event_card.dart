import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tumble/core/models/api_models/available_user_event_model.dart';

class AvailableEventCard extends StatelessWidget {
  final AvailableUserEventModel event;

  const AvailableEventCard({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            gradient: RadialGradient(
              colors: [Colors.red, Colors.white],
              radius: 1.2,
              center: Alignment(1, 1),
            )),
        child: ExpansionTile(
          textColor: Theme.of(context).colorScheme.onSurface,
          iconColor: Theme.of(context).colorScheme.onSurface,
          subtitle: Text(DateFormat("dd-MM-yyyy").format(event.lastSignupDate)),
          title: Text(event.title),
          children: const [
            SizedBox(
              height: 200,
            )
          ],
        ),
      ),
    );
  }
}
