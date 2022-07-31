import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tumble/core/models/api_models/available_user_event_model.dart';

class AvailableEventCard extends StatelessWidget {
  const AvailableEventCard({Key? key, required this.event}) : super(key: key);

  final AvailableUserEventModel event;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(event.title),
        Text(event.lastSignupDate.toString()),
      ],
    );
  }
}
