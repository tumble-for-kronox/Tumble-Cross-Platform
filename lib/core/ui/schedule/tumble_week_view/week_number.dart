import 'package:flutter/material.dart';
import 'package:tumble/core/models/ui_models/week_model.dart';
import 'package:tumble/core/ui/data/string_constants.dart';

class WeekNumber extends StatelessWidget {
  final Week week;
  const WeekNumber({Key? key, required this.week}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        right: 20,
        top: 20,
        child: Text(
          S.weekViewPage.weekNumber(week.weekNumber.toString()),
          style:
              TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: 20, fontWeight: FontWeight.w300),
        ));
  }
}
