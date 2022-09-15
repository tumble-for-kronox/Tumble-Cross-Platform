import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:tumble/core/models/api_models/resource_model.dart';

class TimeStampCard extends StatelessWidget {
  final TimeSlot timeSlot;

  const TimeStampCard({Key? key, required this.timeSlot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => {},
      child: Container(
        width: 200,
        height: 50,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 2, offset: Offset(0, 1))],
        ),
        child: Text(
          "${DateFormat.Hm().format(timeSlot.from)} - ${DateFormat.Hm().format(timeSlot.to)}",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
