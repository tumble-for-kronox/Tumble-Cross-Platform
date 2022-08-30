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
import 'package:tumble/core/ui/data/string_constants.dart';
import 'package:tumble/core/ui/main_app/cubit/main_app_cubit.dart';

import '../../models/api_models/schedule_model.dart';
import '../../navigation/app_navigator.dart';
import '../../theme/data/colors.dart';
import '../data/groups/scaffold_message_types.dart';
import '../permission_handler.dart';
import '../scaffold_message.dart';

class EventOptions extends StatelessWidget {
  final MainAppCubit cubit;
  final Event event;
  final BuildContext context;

  const EventOptions(
      {Key? key,
      required this.cubit,
      required this.event,
      required this.context})
      : super(key: key);

  static void showEventOptions(
      BuildContext context, Event event, MainAppCubit cubit) {
    showModalBottomSheet(
        context: context,
        builder: (_) =>
            EventOptions(cubit: cubit, event: event, context: context));
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: FutureBuilder(
            future: Future.wait([
              cubit.checkIfNotificationIsSetForEvent(event),
              cubit.checkifNotificationIsSetForCourse(event),
            ]),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                bool notificationIsSetForEvent =
                    (snapshot.data! as List<bool>)[0];
                bool notificationIsSetForCourse =
                    (snapshot.data! as List<bool>)[1];
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (event.from.isAfter(DateTime.now()))
                      _buildNotificationTiles(notificationIsSetForEvent,
                          notificationIsSetForCourse),
                    const Divider(
                      height: 1,
                    ),
                    ListTile(
                      leading: Icon(CupertinoIcons.color_filter,
                          color: Theme.of(context).colorScheme.onSurface),
                      title: Center(
                          child: Text(
                        S.eventOptions.changeCourseColor(),
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface),
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
                              title: Text(S.eventOptions.colorPickerTitle()),
                              content: SingleChildScrollView(
                                child: HueRingPicker(
                                  pickerColor: pickerColor,
                                  onColorChanged: (Color newColor) =>
                                      pickerColor = newColor,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(S.general.cancel()),
                                ),
                                TextButton(
                                  onPressed: () {
                                    cubit.changeCourseColor(
                                        context, event.course, pickerColor);
                                    cubit.setLoading();
                                    Navigator.pop(context);
                                  },
                                  child: Text(S.general.done()),
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

  Column _buildNotificationTiles(
      bool notificationIsSetForEvent, notificationIsSetForCourse) {
    return Column(children: [
      ListTile(
        leading: Icon(
            notificationIsSetForEvent
                ? CupertinoIcons.bell_slash
                : CupertinoIcons.bell,
            color: Theme.of(context).colorScheme.onSurface),
        title: Center(
            child: Text(
          notificationIsSetForEvent
              ? S.eventOptions.removeEventNotification()
              : S.eventOptions.addEventNotification(),
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

          if (notificationIsSetForEvent) {
            cubit.cancelEventNotification(event).then((notificationCancelled) =>
                notificationCancelled
                    ? showScaffoldMessage(
                        context,
                        S.scaffoldMessages
                            .cancelledEventNotification(event.title))
                    : showScaffoldMessage(
                        context,
                        S.scaffoldMessages
                            .cancelNotificationsFailed(event.title)));
          } else {
            bool sucessfullyCreatedNotifications =
                await cubit.createNotificationForEvent(event, context);
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
        leading: Icon(
            notificationIsSetForCourse
                ? CupertinoIcons.slash_circle
                : CupertinoIcons.bell_circle,
            color: Theme.of(context).colorScheme.onSurface),
        title: Center(
            child: Text(
          notificationIsSetForCourse
              ? S.eventOptions.removeCourseNotifications()
              : S.eventOptions.addCourseNotifications(),
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        )),
        onTap: () async {
          Navigator.of(context).pop();

          if (notificationIsSetForCourse) {
            cubit.cancelCourseNotifications(event).then(
                (notificationCancelled) => notificationCancelled
                    ? showScaffoldMessage(
                        context,
                        S.scaffoldMessages.cancelledCourseNotifications(
                            event.course.englishName))
                    : showScaffoldMessage(
                        context,
                        S.scaffoldMessages
                            .cancelNotificationsFailed(event.title)));
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
      )
    ]);
  }
}
