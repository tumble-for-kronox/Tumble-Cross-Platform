import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/models/api_models/schedule_model.dart';
import 'package:tumble/core/ui/app_switch/cubit/app_switch_cubit.dart';
import 'package:tumble/core/ui/schedule/event_modal.dart';

class TumbleWeekEventTile extends StatelessWidget {
  final Event event;
  final AppSwitchCubit mainAppCubit;
  const TumbleWeekEventTile({Key? key, required this.event, required this.mainAppCubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final courseColor = mainAppCubit.getColorForCourse(event);
    return Container(
      height: 23,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(5),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Colors.black26,
            blurRadius: 1,
            offset: Offset(0, 1),
          )
        ],
      ),
      child: ClipPath(
        clipper: ShapeBorderClipper(
            shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        )),
        child: Shimmer(
          color: Colors.redAccent,
          colorOpacity: 0.2,
          enabled: event.isSpecial,
          child: MaterialButton(
            padding: const EdgeInsets.all(0),
            onPressed: () => TumbleEventModal.showBookmarkEventModal(
                context, event, mainAppCubit.getColorForCourse(event), mainAppCubit),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 5,
                  decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.only(topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)),
                      color: event.isSpecial ? Colors.redAccent : courseColor),
                ),
                Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Container(
                      width: 100,
                      color: event.isSpecial ? Colors.redAccent.withOpacity(0.35) : courseColor.withOpacity(0.35),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        "${DateFormat.Hm(Localizations.localeOf(context).languageCode).format(event.from)} - ${DateFormat.Hm(Localizations.localeOf(context).languageCode).format(event.to)}",
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
                      event.title.capitalize(),
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
        ),
      ),
    );
  }
}
