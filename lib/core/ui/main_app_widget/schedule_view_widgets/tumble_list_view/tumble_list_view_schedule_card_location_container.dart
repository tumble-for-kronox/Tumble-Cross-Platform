import 'package:flutter/material.dart';
import 'package:tumble/core/models/api_models/schedule_model.dart';

class ScheduleCardLocationContainer extends StatelessWidget {
  final List<Location> locations;
  final Color textColor;
  const ScheduleCardLocationContainer(
      {Key? key, required this.locations, required this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10, right: 10),
      alignment: Alignment.bottomRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            locations.isEmpty ? "" : locations.first.name,
            softWrap: true,
            style: TextStyle(
              color: textColor,
              fontSize: 21,
              fontWeight: FontWeight.w200,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: Icon(
              Icons.location_on_outlined,
              size: 20,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
