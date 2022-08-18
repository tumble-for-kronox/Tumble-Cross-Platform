import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tumble/core/ui/main_app/cubit/main_app_cubit.dart';

import '../../models/api_models/schedule_model.dart';
import '../data/scaffold_message_types.dart';
import '../permission_handler.dart';
import '../scaffold_message.dart';

class EventOptions extends StatelessWidget {
  final MainAppCubit cubit;
  final Event event;
  final BuildContext context;

  const EventOptions({Key? key, required this.cubit, required this.event, required this.context}) : super(key: key);

  static void showEventOptions(BuildContext context, Event event, MainAppCubit cubit) {
    if (cubit.isDefault(event.id)) {
      showModalBottomSheet(
          context: context, builder: (_) => EventOptions(cubit: cubit, event: event, context: context));
    } else {
      showScaffoldMessage(context, ScaffoldMessageType.createdNotificationFailed());
    }
  }

  @override
  Widget build(BuildContext _) {
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
            child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, mainAxisSize: MainAxisSize.max, children: [
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
                  bool sucessfullyCreatedNotifications = await cubit.createNotificationForCourse(event, context);
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
  }
}
