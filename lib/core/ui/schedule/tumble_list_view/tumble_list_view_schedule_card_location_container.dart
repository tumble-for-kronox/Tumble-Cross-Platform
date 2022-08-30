import 'package:flutter/cupertino.dart';
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                locations.isEmpty ? "Unknown" : locations.first.id,
                softWrap: true,
                style: TextStyle(
                  color: textColor,
                  fontSize: locations.isEmpty ? 16 : 19,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 2, left: 10),
                child: Icon(
                  CupertinoIcons.location,
                  size: 20,
                  color: textColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
