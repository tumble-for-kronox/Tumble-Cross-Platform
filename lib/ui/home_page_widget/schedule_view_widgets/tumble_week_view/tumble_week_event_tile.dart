import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tumble/models/api_models/schedule_model.dart';
import 'package:tumble/ui/home_page_widget/schedule_view_widgets/event_details/event_details_page.dart';

class TumbleWeekEventTile extends StatelessWidget {
  final Event event;
  const TumbleWeekEventTile({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 23,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(2),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Colors.black26,
            blurRadius: 1,
          )
        ],
      ),
      child: MaterialButton(
        padding: const EdgeInsets.all(0),
        onPressed: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => EventDetailsPage(event: event)));
        },
        child: Row(
          children: [
            Container(
              width: 3,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(2),
                    bottomLeft: Radius.circular(2)),
                color: Color(int.parse(
                    "ff${event.course.color.replaceAll("#", "")}",
                    radix: 16)),
              ),
            ),
            Stack(
              alignment: Alignment.centerLeft,
              children: [
                Container(
                  width: 100,
                  color: Color(int.parse(
                          "ff${event.course.color.replaceAll("#", "")}",
                          radix: 16))
                      .withOpacity(0.35),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    "${DateFormat("HH:mm").format(event.timeStart)} - ${DateFormat("HH:mm").format(event.timeEnd)}",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(
                  left: 5,
                  right: 5,
                ),
                child: Text(
                  event.title,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
