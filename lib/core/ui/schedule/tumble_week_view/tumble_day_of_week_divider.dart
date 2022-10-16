import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/models/backend_models/schedule_model.dart';
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
            "${DateFormat.EEEE(Localizations.localeOf(context).languageCode).format(day.isoString).capitalize()} ${DateFormat("d/M", Localizations.localeOf(context).languageCode).format(day.isoString)}",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 19.5,
              fontWeight: FontWeight.w400,
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
                    Container(padding: const EdgeInsets.only(right: 3), child: Text(S.weekViewPage.todayLabel()))
                  ]),
                )
              : Container(),
        ],
      ),
    );
  }
}
