import 'package:flutter/cupertino.dart';
import 'package:tumble/core/models/backend_models/schedule_model.dart';
import 'package:tumble/core/ui/data/string_constants.dart';

class ScheduleCardLocationContainer extends StatelessWidget {
  final List<Location> locations;
  final Color textColor;
  const ScheduleCardLocationContainer({super.key, required this.locations, required this.textColor});

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
              Padding(
                padding: const EdgeInsets.only(bottom: 2, left: 10),
                child: Icon(
                  CupertinoIcons.location_solid,
                  size: 20,
                  color: textColor,
                ),
              ),
              const SizedBox(
                width: 2.5,
              ),
              Text(
                locations.isEmpty ? S.general.unknown() : locations.first.id,
                softWrap: true,
                style: TextStyle(
                  color: textColor,
                  fontSize: locations.isEmpty ? 16 : 19,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
