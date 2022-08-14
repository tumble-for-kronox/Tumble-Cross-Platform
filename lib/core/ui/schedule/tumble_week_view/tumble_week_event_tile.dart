import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tumble/core/models/api_models/schedule_model.dart';
import 'package:tumble/core/models/ui_models/course_ui_model.dart';
import 'package:tumble/core/theme/data/colors.dart';
import 'package:tumble/core/ui/main_app/cubit/main_app_cubit.dart';
import 'package:tumble/core/ui/schedule/event_modal.dart';

class TumbleWeekEventTile extends StatelessWidget {
  final Event event;
  final MainAppCubit cubit;
  const TumbleWeekEventTile(
      {Key? key, required this.event, required this.cubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final courseColor = cubit.getColorForCourse(event);
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
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) => TumbleEventModal(
                  event: event,
                  color: event.isSpecial
                      ? Colors.redAccent
                      : courseColor));
        },
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 3,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(2),
                      bottomLeft: Radius.circular(2)),
                  color: event.isSpecial
                      ? Colors.redAccent
                      : courseColor),
            ),
            Stack(
              alignment: Alignment.centerLeft,
              children: [
                Container(
                  width: 100,
                  color: event.isSpecial
                      ? Colors.redAccent.withOpacity(0.35)
                      : courseColor
                          .withOpacity(0.35),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    "${DateFormat("HH:mm").format(event.from)} - ${DateFormat("HH:mm").format(event.to)}",
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
