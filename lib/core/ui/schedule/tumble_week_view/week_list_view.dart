import 'package:flutter/material.dart';
import 'package:tumble/core/models/ui_models/week_model.dart';
import 'package:tumble/core/ui/schedule/tumble_week_view/week_mapper.dart';
import 'package:tumble/core/ui/schedule/tumble_week_view/week_number.dart';

class TumbleWeekPageContainer extends StatefulWidget {
  final Week week;

  const TumbleWeekPageContainer({Key? key, required this.week}) : super(key: key);

  @override
  State<TumbleWeekPageContainer> createState() => _TumbleWeekPageContainerState();
}

class _TumbleWeekPageContainerState extends State<TumbleWeekPageContainer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WeekMapper(
          week: widget.week,
        ),
        WeekNumber(
          week: widget.week,
        )
      ],
    );
  }
}
