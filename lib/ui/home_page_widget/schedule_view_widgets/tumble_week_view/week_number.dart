import 'package:flutter/material.dart';
import 'package:tumble/models/ui_models/week_model.dart';

class WeekNumber extends StatelessWidget {
  final Week week;
  const WeekNumber({Key? key, required this.week}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        right: 20,
        top: MediaQuery.of(context).viewPadding.top + 50,
        child: Text(
          "w. ${week.weekNumber}",
          style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 20,
              fontWeight: FontWeight.w300),
        ));
  }
}
