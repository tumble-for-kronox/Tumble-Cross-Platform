import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tumble/models/api_models/schedule_model.dart';
import 'package:tumble/theme/data/colors.dart';
import 'package:tumble/ui/main_app_widget/schedule_view_widgets/tumble_list_view/tumble_list_view_schedule_card_location_container.dart';
import 'package:tumble/ui/main_app_widget/schedule_view_widgets/tumble_list_view/tumble_list_view_schedule_card_ribbon.dart';
import 'package:tumble/ui/main_app_widget/schedule_view_widgets/tumble_list_view/tumble_list_view_schedule_card_time_stamp.dart';

class ScheduleCard extends StatelessWidget {
  final Event event;
  final VoidCallback onTap;

  const ScheduleCard({
    Key? key,
    required this.event,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 5),
        child: Stack(
          children: [
            Container(
              height: 150,
              width: double.infinity,
              margin: const EdgeInsets.only(top: 9, left: 10, right: 10),
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                  color:
                      event.isSpecial ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 1, offset: Offset(0, 1))]),
              child: MaterialButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: onTap,
                  child: Container(
                      padding: const EdgeInsets.only(left: 10, top: 15),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FractionallySizedBox(
                            widthFactor: 0.85,
                            alignment: Alignment.topLeft,
                            child: Text(event.title,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: event.isSpecial
                                      ? CustomColors.lightColors.secondary
                                      : Theme.of(context).colorScheme.onSecondary,
                                  fontSize: 19,
                                  fontWeight: FontWeight.w400,
                                )),
                          ),
                          Expanded(
                            child: Stack(
                              children: [
                                Container(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(event.course.englishName,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: event.isSpecial
                                              ? CustomColors.lightColors.secondary
                                              : Theme.of(context).colorScheme.onSecondary,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300,
                                        ))),
                                ScheduleCardLocationContainer(
                                    textColor: event.isSpecial
                                        ? CustomColors.lightColors.secondary
                                        : Theme.of(context).colorScheme.onSecondary,
                                    locations: event.locations),
                                ScheduleCardTimeStamp(
                                    textColor: event.isSpecial
                                        ? CustomColors.lightColors.secondary
                                        : Theme.of(context).colorScheme.onSecondary,
                                    timeStart: event.timeStart,
                                    timeEnd: event.timeEnd)
                              ],
                            ),
                          ),
                        ],
                      ))),
            ),
            const ScheduleCardRibbon(color: '#cccccc')
          ],
        ));
  }
}
