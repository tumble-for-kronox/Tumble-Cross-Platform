import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tumble/core/dependency_injection/get_it_instances.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/ui/main_app/cubit/main_app_cubit.dart';

import '../../models/api_models/schedule_model.dart';
import '../../navigation/app_navigator.dart';
import '../../theme/data/colors.dart';
import '../data/scaffold_message_types.dart';
import '../permission_handler.dart';
import '../scaffold_message.dart';

class EventOptions extends StatelessWidget {
  final MainAppCubit cubit;
  final Event event;
  final BuildContext context;
  final AwesomeNotifications _notifications = getIt<AwesomeNotifications>();

  EventOptions({Key? key, required this.cubit, required this.event, required this.context}) : super(key: key);

  static void showEventOptions(BuildContext context, Event event, MainAppCubit cubit) {
    if (cubit.isDefault(event.id)) {
      showModalBottomSheet(
          context: context, builder: (_) => EventOptions(cubit: cubit, event: event, context: context));
    } else {
      showScaffoldMessage(context, ScaffoldMessageType.openEventOptionsFailed());
    }
  }

  @override
  Widget build(BuildContext _) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
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
              cubit.isNotificationSetForEvent(event),
              cubit.isNotificationSetForCourse(event),
            ]),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                bool eventNotification = (snapshot.data! as List<bool>)[0];
                bool courseNotification = (snapshot.data! as List<bool>)[1];
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: Icon(eventNotification ? CupertinoIcons.bell_slash : CupertinoIcons.bell,
                          color: Theme.of(context).colorScheme.onSurface),
                      title: Center(
                          child: Text(
                        eventNotification ? 'Remove notification for event' : 'Set notification for event',
                        style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                      )),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      onTap: () async {
                        Navigator.of(context).pop();

                        if (eventNotification) {
                          cubit.cancelEventNotification(event).then((notificationCancelled) => notificationCancelled
                              ? showScaffoldMessage(
                                  context, ScaffoldMessageType.cancelledEventNotification(event.title))
                              : showScaffoldMessage(
                                  context, ScaffoldMessageType.cancelNotificationsFailed(event.title)));
                        } else {
                          bool sucessfullyCreatedNotifications = await cubit.createNotificationForEvent(event, context);
                          if (!sucessfullyCreatedNotifications) {
                            await showDialog(
                                useRootNavigator: false,
                                context: context,
                                builder: (_) => PermissionHandler(
                                      cubit: cubit,
                                    ));
                          }
                        }
                      },
                    ),
                    const Divider(
                      height: 1,
                    ),
                    ListTile(
                      leading: Icon(courseNotification ? CupertinoIcons.slash_circle : CupertinoIcons.bell_circle,
                          color: Theme.of(context).colorScheme.onSurface),
                      title: Center(
                          child: Text(
                        courseNotification ? 'Remove all nofitications for course' : 'Set notifications for course',
                        style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                      )),
                      onTap: () async {
                        Navigator.of(context).pop();

                        if (courseNotification) {
                          cubit.cancelCourseNotifications(event).then((notificationCancelled) => notificationCancelled
                              ? showScaffoldMessage(
                                  context, ScaffoldMessageType.cancelledCourseNotifications(event.course.englishName))
                              : showScaffoldMessage(
                                  context, ScaffoldMessageType.cancelNotificationsFailed(event.title)));
                        } else {
                          bool sucessfullyCreatedNotifications =
                              await cubit.createNotificationForCourse(event, context);
                          if (!sucessfullyCreatedNotifications) {
                            await showDialog(
                                useRootNavigator: false,
                                context: context,
                                builder: (_) => PermissionHandler(
                                      cubit: cubit,
                                    ));
                          }
                        }
                      },
                    ),
                    const Divider(
                      height: 1,
                    ),
                    ListTile(
                      leading: Icon(CupertinoIcons.color_filter, color: Theme.of(context).colorScheme.onSurface),
                      title: Center(
                          child: Text(
                        "Change course color",
                        style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                      )),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      onTap: () async {
                        showDialog(
                          context: context,
                          builder: (context) {
                            Color pickerColor = cubit.getColorForCourse(event);
                            return AlertDialog(
                              title: const Text("Pick a color"),
                              content: SingleChildScrollView(
                                child: HueRingPicker(
                                  pickerColor: pickerColor,
                                  onColorChanged: (Color newColor) => pickerColor = newColor,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("Cancel"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    cubit.changeCourseColor(context, event.course, pickerColor);
                                    cubit.setLoading();
                                    cubit.fetchNewSchedule(cubit.state.currentScheduleId!);
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Done"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    )
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
    );
  }
}
