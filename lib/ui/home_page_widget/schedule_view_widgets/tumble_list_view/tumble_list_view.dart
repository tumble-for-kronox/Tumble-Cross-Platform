import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tumble/models/api_models/schedule_model.dart';
import 'tumble_list_view_day_container.dart';

class TumbleListView extends StatelessWidget {
  final String? scheduleId;
  final List<Day>? listOfDays;
  const TumbleListView({Key? key, this.scheduleId, this.listOfDays})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          children: listOfDays!
              .where((day) => day.events.isNotEmpty)
              .map((day) => TumbleListViewDayContainer(
                    day: day,
                  ))
              .toList()),
    );
  }
}
