import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduleCardTimeStamp extends StatelessWidget {
  final DateTime timeStart;
  final Color textColor;
  final DateTime timeEnd;
  const ScheduleCardTimeStamp(
      {Key? key,
      required this.timeEnd,
      required this.timeStart,
      required this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        '${DateFormat.Hm().format(timeStart)} - ${DateFormat.Hm().format(timeEnd)}',
        style: TextStyle(
          color: textColor,
          fontSize: 21,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}
