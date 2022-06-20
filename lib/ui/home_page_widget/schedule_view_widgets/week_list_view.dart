import 'package:flutter/material.dart';
import 'package:tumble/models/ui_models/week_model.dart';

class WeekWidget extends StatelessWidget {
  final Week week;
  final String scheduleId;

  const WeekWidget({
    Key? key,
    required this.week,
    required this.scheduleId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        children: [
          ListView.builder(
            itemCount: week.events.length,
            scrollDirection: Axis.vertical,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            itemBuilder: ((context, index) {
              final currentObj = week.events[index];

              if (currentObj is DayDivider) {
                return Container(
                  padding: index == 0
                      ? const EdgeInsets.only(
                          top: 80,
                          bottom: 5,
                          left: 20,
                          right: 20,
                        )
                      : const EdgeInsets.only(
                          top: 15,
                          bottom: 5,
                          left: 20,
                          right: 20,
                        ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        currentObj.dayName + " " + currentObj.date,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      () {
                        List<String> dateSplit = currentObj.date.split('/');
                        if (DateTime.now().day.toString() == dateSplit[0] &&
                            DateTime.now().month.toString() == dateSplit[1]) {
                          return Expanded(
                            child: Divider(
                              height: 0,
                              thickness: 1,
                              indent: 20,
                              endIndent: 20,
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          );
                        }
                        return Container();
                      }(),
                      () {
                        List<String> dateSplit = currentObj.date.split('/');
                        if (DateTime.now().day.toString() == dateSplit[0] &&
                            DateTime.now().month.toString() == dateSplit[1]) {
                          return const Text("Today");
                        }
                        return Container();
                      }(),
                    ],
                  ),
                );
              } else if (currentObj is Schedule) {
                if (index == week.events.length - 1) {
                  return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: WeekEvent(
                        event: currentObj,
                        scheduleId: scheduleId,
                        notificationChannelId:
                            (currentObj).notificationChannelId,
                      ));
                } else {
                  return WeekEvent(
                      event: currentObj,
                      scheduleId: scheduleId,
                      notificationChannelId:
                          (currentObj).notificationChannelId);
                }
              } else {
                if (index == week.events.length - 1) {
                  return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: WeekEvent(
                        empty: true,
                        scheduleId: scheduleId,
                      ));
                } else {
                  return WeekEvent(empty: true, scheduleId: scheduleId);
                }
              }
            }),
          ),
          Positioned(
            right: 20,
            top: MediaQuery.of(context).viewPadding.top + 50,
            child: Text(
              "w. " + week.weekNumber,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 20,
                  fontWeight: FontWeight.w300),
            ),
          )
        ],
      ),
    );
  }
}
