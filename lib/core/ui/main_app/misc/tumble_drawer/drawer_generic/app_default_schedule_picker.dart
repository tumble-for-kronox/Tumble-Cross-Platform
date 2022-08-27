import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tumble/core/ui/main_app/misc/tumble_drawer/cubit/drawer_state.dart';
import 'package:tumble/core/ui/scaffold_message.dart';

typedef ToggleSchedule = void Function(String id, bool toggleValue);

class AppFavoriteScheduleToggle extends StatelessWidget {
  final List<String> scheduleIds;
  final DrawerCubit cubit;
  final ToggleSchedule toggleSchedule;
  const AppFavoriteScheduleToggle(
      {Key? key,
      required this.scheduleIds,
      required this.toggleSchedule,
      required this.cubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 240,
        margin: const EdgeInsets.only(bottom: 25, left: 12, right: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
        ),
        child: SizedBox.expand(
            child: Card(
          elevation: 0,
          color: Theme.of(context).colorScheme.surface,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: SingleChildScrollView(
            child: Column(
                children: (scheduleIds).map((id) {
              return SwitchListTile(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                title: Text(
                  id,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                onChanged: (bool value) {
                  toggleSchedule(id, value);
                },
                value: cubit.getScheduleToggleValue(id),
              );
            }).toList()),
          ),
        )),
      ),
    );
  }
}
