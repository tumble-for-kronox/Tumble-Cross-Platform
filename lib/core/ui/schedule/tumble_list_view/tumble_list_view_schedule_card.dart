import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/models/backend_models/schedule_model.dart';
import 'package:tumble/core/ui/schedule/tumble_list_view/tumble_list_view_schedule_card_location_container.dart';

class ScheduleCard extends StatelessWidget {
  final Event event;
  final VoidCallback onTap;
  final Color color;

  const ScheduleCard({
    super.key,
    required this.event,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 5),
        child: Stack(
          children: [
            Container(
              height: 135,
              width: double.infinity,
              margin: const EdgeInsets.only(top: 9, left: 10, right: 10, bottom: 5),
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 2, offset: Offset(0, 1))]),
              child: ClipPath(
                clipper: ShapeBorderClipper(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                child: Shimmer(
                  color: Colors.redAccent,
                  colorOpacity: 0.2,
                  enabled: event.isSpecial,
                  child: MaterialButton(
                      padding: const EdgeInsets.all(0),
                      onPressed: onTap,
                      color: Theme.of(context).colorScheme.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Container(
                          padding: const EdgeInsets.only(left: 24, top: 15),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FractionallySizedBox(
                                widthFactor: 1,
                                alignment: Alignment.topLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 2),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                width: 5,
                                                height: 5,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: color,
                                                ),
                                              ),
                                              const SizedBox(width: 6),
                                              Container(
                                                padding: const EdgeInsets.only(top: 1),
                                                child: Text(
                                                  '${DateFormat.Hm(Localizations.localeOf(context).languageCode).format(event.from)} - ${DateFormat.Hm(Localizations.localeOf(context).languageCode).format(event.to)}',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w400,
                                                      color: Theme.of(context).colorScheme.onSecondary,
                                                      letterSpacing: .5),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(right: 12),
                                            child: event.isSpecial
                                                ? const Icon(
                                                    CupertinoIcons.exclamationmark_square,
                                                    size: 24,
                                                  )
                                                : null,
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 7.5,
                                    ),
                                    Text(event.title.capitalize(),
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Theme.of(context).colorScheme.onSurface,
                                          fontSize: 20,
                                          letterSpacing: .5,
                                          fontWeight: FontWeight.w400,
                                        )),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Stack(
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.only(top: 10, right: 4),
                                        child: Text(event.course.englishName,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Theme.of(context).colorScheme.onSurface,
                                              fontSize: 16.5,
                                              letterSpacing: .5,
                                              fontWeight: FontWeight.w300,
                                            ))),
                                    ScheduleCardLocationContainer(
                                        textColor: Theme.of(context).colorScheme.onSecondary,
                                        locations: event.locations),
                                  ],
                                ),
                              ),
                            ],
                          ))),
                ),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(top: 9, left: 10, right: 10),
                alignment: Alignment.topLeft,
                child: Container(
                  decoration: BoxDecoration(
                      color: color,
                      borderRadius:
                          const BorderRadius.only(topLeft: Radius.circular(5), bottomLeft: Radius.circular(5))),
                  width: 8,
                  height: 135,
                )),
          ],
        ));
  }
}
