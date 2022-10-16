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
      height: 32.5,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
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
                    color: courseColor,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 8),
                  child: Row(
                    children: [
                      Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: courseColor,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.only(top: 1),
                        child: Text(
                          '${DateFormat.Hm(Localizations.localeOf(context).languageCode).format(event.from)} - ${DateFormat.Hm(Localizations.localeOf(context).languageCode).format(event.to)}',
                          style: TextStyle(
                              fontSize: 15.5,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).colorScheme.onBackground,
                              letterSpacing: .5),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(
                      left: 5,
                      right: 7,
                    ),
                    child: Text(
                      event.title.capitalize(),
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
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
