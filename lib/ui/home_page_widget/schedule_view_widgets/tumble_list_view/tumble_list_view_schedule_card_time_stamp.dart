import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:intl/intl.dart';

class ScheduleCardTimeStamp extends StatelessWidget {
  final DateTime timeStart;
  final DateTime timeEnd;
  const ScheduleCardTimeStamp(
      {Key? key, required this.timeEnd, required this.timeStart})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        '${DateFormat.Hm().format(timeStart)} - ${DateFormat.Hm().format(timeEnd)}',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 21,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}
