import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tumble/models/api_models/schedule_model.dart';
import 'day_item.dart';

class TumbleListView extends StatefulWidget {
  final String? scheduleId;
  final List<Day>? listView;
  const TumbleListView({Key? key, this.scheduleId, this.listView})
      : super(key: key);

  @override
  State<TumbleListView> createState() => _TumbleListViewState();
}

class _TumbleListViewState extends State<TumbleListView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          children: widget.listView!
              .map((day) => DayItem(
                    day: day,
                    onTap: () {},
                  ))
              .toList()),
    );
  }
}

