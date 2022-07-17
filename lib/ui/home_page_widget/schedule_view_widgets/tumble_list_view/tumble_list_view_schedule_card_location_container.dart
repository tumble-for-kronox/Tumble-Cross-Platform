import 'package:flutter/material.dart';
import 'package:tumble/models/api_models/schedule_model.dart';

class ScheduleCardLocationContainer extends StatelessWidget {
  final List<Location> locations;
  const ScheduleCardLocationContainer({Key? key, required this.locations})
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
          const Padding(
            padding: EdgeInsets.only(bottom: 3),
            child: Icon(
              Icons.location_on_outlined,
              size: 20,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: Column(
                children: locations
                    .map(
                      (location) => Text(
                        location.name,
                        softWrap: true,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    )
                    .toList()),
          )
        ],
      ),
    );
  }
}
