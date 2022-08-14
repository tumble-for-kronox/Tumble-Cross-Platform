import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tumble/core/models/api_models/schedule_model.dart';
import 'package:tumble/core/models/ui_models/course_ui_model.dart';
import 'package:tumble/core/theme/data/colors.dart';
import 'package:tumble/core/ui/main_app/cubit/main_app_cubit.dart';
import 'package:tumble/core/ui/main_app/main_app.dart';
import 'package:tumble/core/ui/permission_handler.dart';
import 'package:tumble/core/ui/scaffold_message.dart';
import 'package:tumble/core/ui/schedule/event_modal.dart';
import 'package:tumble/core/ui/schedule/tumble_list_view/tumble_list_view_schedule_card.dart';

class TumbleListViewDayContainer extends StatelessWidget {
  final Day day;
  final MainAppCubit mainAppCubit;
  const TumbleListViewDayContainer({Key? key, required this.day, required this.mainAppCubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 20),
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              Text("${day.name} ${day.date}",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground, fontSize: 17, fontWeight: FontWeight.w400)),
              Expanded(
                  child: Divider(
                color: Theme.of(context).colorScheme.onBackground,
                indent: 6,
                thickness: 1,
              ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 2),
            child: Column(
              children: day.events
                  .map((event) => GestureDetector(
                        onLongPress: () {
                          if (mainAppCubit.isDefault(event.id)) {
                            showConfirmationModal(context, event, mainAppCubit);
                          } else {
                            showScaffoldMessage(context, 'Schedule must be default to be able to set notifications');
                          }
                        },
                        child: ScheduleCard(
                            event: event,
                            color: event.isSpecial ? Colors.redAccent : mainAppCubit.getColorForCourse(event),
                            onTap: () {
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) => TumbleEventModal(
                                      event: event,
                                      color:
                                          event.isSpecial ? Colors.redAccent : mainAppCubit.getColorForCourse(event)));
                            }),
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}

showConfirmationModal(BuildContext context, Event event, MainAppCubit cubit) {
  showModalBottomSheet(
      useRootNavigator: false,
      context: context,
      builder: (BuildContext ctx) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 135,
            margin: const EdgeInsets.only(bottom: 25, left: 12, right: 12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
            ),
            child: SizedBox.expand(
                child: Card(
              elevation: 0,
              color: Theme.of(context).colorScheme.surface,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ListTile(
                        title: const Center(child: Text('Set notification for event')),
                        onTap: () async {
                          Navigator.of(context).pop();
                          bool sucessfullyCreatedNotifications = await cubit.createNotificationForEvent(event, context);

                          if (!sucessfullyCreatedNotifications) {
                            await showDialog(
                                useRootNavigator: false,
                                context: context,
                                builder: (_) => PermissionHandler(
                                      cubit: cubit,
                                    ));
                          }
                        },
                      ),
                      const Divider(
                        height: 10,
                      ),
                      ListTile(
                        title: const Center(child: Text('Set notifications for course')),
                        onTap: () async {
                          Navigator.of(context).pop();
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
                        },
                      )
                    ]),
              ),
            )),
          ),
        );
      });
}
