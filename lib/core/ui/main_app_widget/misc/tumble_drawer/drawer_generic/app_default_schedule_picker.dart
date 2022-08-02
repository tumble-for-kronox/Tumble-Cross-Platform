import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tumble/core/ui/scaffold_message.dart';

typedef SetDefaultSchedule = void Function(String id);

class AppDefaultSchedulePicker extends StatelessWidget {
  final List<String> scheduleIds;
  final SetDefaultSchedule setDefaultSchedule;
  const AppDefaultSchedulePicker(
      {Key? key, required this.scheduleIds, required this.setDefaultSchedule})
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
                children: (scheduleIds)
                    .map((id) => ListTile(
                        title: Text(
                          id,
                          style: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.onBackground),
                        ),
                        onTap: () {
                          setDefaultSchedule(id);
                          showScaffoldMessage(
                              context, "Default schedule is now set to $id");
                        }))
                    .toList()),
          ),
        )),
      ),
    );
  }
}
