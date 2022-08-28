import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tumble/core/models/api_models/bookmarked_schedule_model.dart';
import 'package:tumble/core/ui/main_app/misc/tumble_drawer/cubit/drawer_state.dart';
import 'package:tumble/core/ui/scaffold_message.dart';

typedef ToggleSchedule = void Function(String id, bool toggleValue);

class AppFavoriteScheduleToggle extends StatefulWidget {
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
  State<AppFavoriteScheduleToggle> createState() =>
      _AppFavoriteScheduleToggleState();
}

class _AppFavoriteScheduleToggleState extends State<AppFavoriteScheduleToggle> {
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
                children: (widget.scheduleIds).map((id) {
              return SwitchListTile(
                secondary: IconButton(
                  icon: Icon(CupertinoIcons.add_circled_solid),
                  onPressed: null,
                ),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                title: Text(
                  bookmarkedScheduleModelFromJson(id).scheduleId,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                onChanged: (bool value) {
                  widget.toggleSchedule(id, value);
                },
                value: widget.cubit.getScheduleToggleValue(id),
              );
            }).toList()),
          ),
        )),
      ),
    );
  }
}
