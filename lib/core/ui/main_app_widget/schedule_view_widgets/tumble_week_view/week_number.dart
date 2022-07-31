import 'package:flutter/material.dart';
import 'package:tumble/core/models/ui_models/week_model.dart';

class WeekNumber extends StatelessWidget {
  final Week week;
  const WeekNumber({Key? key, required this.week}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        right: 20,
        top: 20,
        child: Text(
          "w. ${week.weekNumber}",
          style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 20,
              fontWeight: FontWeight.w300),
        ));
  }
}
