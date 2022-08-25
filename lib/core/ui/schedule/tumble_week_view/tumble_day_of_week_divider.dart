import 'package:flutter/material.dart';
import 'package:tumble/core/models/api_models/schedule_model.dart';
import 'package:tumble/core/ui/data/string_constants.dart';

class DayOfWeekDivider extends StatelessWidget {
  final Day day;
  const DayOfWeekDivider({Key? key, required this.day}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 15,
        bottom: 5,
        left: 20,
        right: 20,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            "${day.name} ${day.date}",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          DateTime.now().day.toString() == day.date.split('/')[0] &&
                  DateTime.now().month.toString() == day.date.split('/')[1]
              ? Expanded(
                  child: Row(children: [
                    Expanded(
                      child: Divider(
                        height: 0,
                        thickness: 1,
                        indent: 20,
                        endIndent: 20,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                    Text(S.weekViewPage.todayLabel())
                  ]),
                )
              : Container(),
        ],
      ),
    );
  }
}
