import 'package:flutter/material.dart';
import 'package:tumble/core/models/ui_models/week_model.dart';
import 'package:tumble/core/ui/data/string_constants.dart';

class WeekNumber extends StatelessWidget {
  final Week week;
  const WeekNumber({super.key, required this.week});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        right: 20,
        top: 19,
        child: Text(
          S.weekViewPage.weekNumber(week.weekNumber.toString()),
          style:
              TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 20, fontWeight: FontWeight.w400),
        ));
  }
}
