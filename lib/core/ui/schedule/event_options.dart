import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/ui/cubit/app_switch_cubit.dart';
import 'package:tumble/core/ui/cubit/schedule_view_cubit.dart';
import 'package:tumble/core/ui/data/string_constants.dart';
import 'package:tumble/core/ui/schedule/cancel_button.dart';

import '../../models/backend_models/schedule_model.dart';
import '../permission_handler.dart';
import '../scaffold_message.dart';

class EventOptions extends StatelessWidget {
  final Event event;
  final BuildContext context;

  const EventOptions({Key? key, required this.event, required this.context}) : super(key: key);

  /// The order in which this widget receives the build context is important,
  /// as it needs the context of the previous widget that called it that has
  /// a ScheduleViewCubit provider
  static void showEventOptions(BuildContext context, Event event) {
    showModalBottomSheet(context: context, builder: (_) => EventOptions(event: event, context: context));
  }

  @override
  Widget build(BuildContext _) {
    return Container(
      height: 325,
      alignment: Alignment.bottomCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 25, left: 12, right: 12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Card(
              elevation: 0,
              color: Theme.of(context).colorScheme.surface,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              child: FutureBuilder(
                future: Future.wait([
                  context.read<ScheduleViewCubit>().checkIfNotificationIsSetForEvent(event),
                  context.read<ScheduleViewCubit>().checkIfNotificationIsSetForCourse(event),
                ]),
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    bool notificationIsSetForEvent = (snapshot.data! as List<bool>)[0];
                    bool notificationIsSetForCourse = (snapshot.data! as List<bool>)[1];
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (event.from.isAfter(DateTime.now())) _buildNotificationEventTiles(notificationIsSetForEvent),
                        ListTile(
                          leading: Icon(
                              notificationIsSetForCourse ? CupertinoIcons.slash_circle : CupertinoIcons.bell_circle,
                              color: Theme.of(context).colorScheme.onSurface),
                          title: Text(
                            notificationIsSetForCourse
                                ? S.eventOptions.removeCourseNotifications()
                                : S.eventOptions.addCourseNotifications(),
                            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                          ),
                          onTap: () async {
                            Navigator.of(context).pop();

                            if (notificationIsSetForCourse) {
                              context.read<ScheduleViewCubit>().cancelCourseNotifications(event).then(
                                  (notificationCancelled) => notificationCancelled
                                      ? showScaffoldMessage(context,
                                          S.scaffoldMessages.cancelNotificationsFailed(event.course.englishName))
                                      : showScaffoldMessage(context,
                                          S.scaffoldMessages.cancelledCourseNotifications(event.course.englishName)));
                            } else {
                              await context
                                  .read<ScheduleViewCubit>()
                                  .createNotificationForCourse(event, context)
                                  .then((allowedAndAmount) async {
                                if ((allowedAndAmount[1] as int) != 0) {
                                  showScaffoldMessage(
                                      context,
                                      S.scaffoldMessages.createdNotificationForCourse(
                                          event.course.englishName, (allowedAndAmount[1] as int)));
                                } else if (!(allowedAndAmount[0] as bool)) {
                                  await showDialog(
                                      useRootNavigator: false,
                                      context: context,
                                      builder: (_) => BlocProvider.value(
                                            value: BlocProvider.of<AppSwitchCubit>(context),
                                            child: const PermissionHandler(),
                                          ));
                                }
                              });
                            }
                          },
                        ),
                        const Divider(
                          height: 1,
                        ),
                        ListTile(
                          leading: Icon(CupertinoIcons.color_filter, color: Theme.of(context).colorScheme.onSurface),
                          title: Text(
                            S.eventOptions.changeCourseColor(),
                            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                          ),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                          onTap: () async {
                            showDialog(
                              context: context,
                              builder: (_) {
                                Color pickerColor =
                                    Color(context.read<ScheduleViewCubit>().state.courseColors![event.course.id]!);
                                return AlertDialog(
                                  title: Text(S.eventOptions.colorPickerTitle()),
                                  content: SingleChildScrollView(
                                    child: HueRingPicker(
                                      pickerColor: pickerColor,
                                      onColorChanged: (Color newColor) => pickerColor = newColor,
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text(S.general.cancel()),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        context
                                            .read<ScheduleViewCubit>()
                                            .changeCourseColor(context, event.course, pickerColor);
                                        context.read<ScheduleViewCubit>().setLoading();
                                        showScaffoldMessage(
                                            context, S.scaffoldMessages.updatedCourseColor(event.course.englishName));
                                        Navigator.pop(context);
                                      },
                                      child: Text(S.general.done()),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    );
                  }
                  return const SizedBox(
                    height: 200,
                  );
                },
              ),
            ),
          ),
          const CancelButton()
        ],
      ),
    );
  }

  Column _buildNotificationEventTiles(bool notificationIsSetForEvent) {
    return Column(children: [
      ListTile(
        leading: Icon(notificationIsSetForEvent ? CupertinoIcons.bell_slash : CupertinoIcons.bell,
            color: Theme.of(context).colorScheme.onSurface),
        title: Text(
          notificationIsSetForEvent ? S.eventOptions.removeEventNotification() : S.eventOptions.addEventNotification(),
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        onTap: () async {
          Navigator.of(context).pop();

          if (notificationIsSetForEvent) {
            context.read<ScheduleViewCubit>().cancelEventNotification(event).then((notificationCancelled) =>
                notificationCancelled
                    ? showScaffoldMessage(
                        context, S.scaffoldMessages.cancelledEventNotification(event.title.capitalize()))
                    : showScaffoldMessage(
                        context, S.scaffoldMessages.cancelNotificationsFailed(event.title.capitalize())));
          } else {
            await context
                .read<ScheduleViewCubit>()
                .createNotificationForEvent(event, context)
                .then((successfullyCreatedNotification) async {
              if (!successfullyCreatedNotification) {
                await showDialog(
                    useRootNavigator: false,
                    context: context,
                    builder: (_) => BlocProvider.value(
                          value: BlocProvider.of<AppSwitchCubit>(context),
                          child: const PermissionHandler(),
                        ));
              } else {
                showScaffoldMessage(context, S.scaffoldMessages.createdNotificationForEvent(event.title.capitalize()));
              }
            });
          }
        },
      ),
      const Divider(
        height: 1,
      ),
    ]);
  }
}
