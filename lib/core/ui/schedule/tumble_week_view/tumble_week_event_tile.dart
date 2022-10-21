import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/models/backend_models/schedule_model.dart';
import 'package:tumble/core/ui/cubit/schedule_view_cubit.dart';
import 'package:tumble/core/ui/schedule/event_modal.dart';

class TumbleWeekEventTile extends StatelessWidget {
  final Event event;
  const TumbleWeekEventTile({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final courseColor = context.read<ScheduleViewCubit>().getColorForCourse(event);
    return Container(
      height: 35,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(2.5),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Colors.black26,
            blurRadius: .5,
            offset: Offset(0, .5),
          )
        ],
      ),
      child: ClipPath(
        child: Shimmer(
          color: Colors.redAccent,
          colorOpacity: 0.2,
          enabled: event.isSpecial,
          child: MaterialButton(
            padding: const EdgeInsets.all(0),
            onPressed: () => TumbleEventModal.showBookmarkEventModal(
                context, event, context.read<ScheduleViewCubit>().getColorForCourse(event)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 5,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(2), bottomLeft: Radius.circular(2)),
                    color: event.isSpecial ? Colors.redAccent : courseColor,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 8),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 10),
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: event.isSpecial ? Colors.redAccent : courseColor,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${DateFormat.Hm(Localizations.localeOf(context).languageCode).format(event.from)} - ${DateFormat.Hm(Localizations.localeOf(context).languageCode).format(event.to)}',
                        style: TextStyle(
                            fontSize: 15.5,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.onSecondary,
                            letterSpacing: .5),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(
                      left: 7,
                      right: 10,
                    ),
                    child: Text(
                      event.title.capitalize(),
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
                event.isSpecial
                    ? Container(
                        padding: const EdgeInsets.only(right: 5),
                        child: const Icon(
                          CupertinoIcons.exclamationmark_square,
                          size: 20,
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
