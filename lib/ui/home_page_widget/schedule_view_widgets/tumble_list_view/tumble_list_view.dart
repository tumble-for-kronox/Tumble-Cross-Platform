import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tumble/models/api_models/schedule_model.dart';
import 'tumble_list_view_day_container.dart';

class TumbleListView extends StatefulWidget {
  final String? scheduleId;
  final List<Day>? listOfDays;
  const TumbleListView({Key? key, this.scheduleId, this.listOfDays})
      : super(key: key);

  @override
  State<TumbleListView> createState() => _TumbleListViewState();
}

class _TumbleListViewState extends State<TumbleListView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          children: widget.listOfDays!
              .map((day) => TumbleListViewDayContainer(
                    day: day,
                  ))
              .toList()),
    );
  }
}
