import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tumble/core/ui/data/string_constants.dart';

typedef SetNotificationTime = void Function(int time);

class AppNotificationTimePicker extends StatelessWidget {
  final Map<String, int> parameterMap = {
    S.settingsPage.offsetTime(15): 15,
    S.settingsPage.offsetTime(30): 30,
    S.settingsPage.offsetTime(60): 60,
    S.settingsPage.offsetTime(180): 180
  };
  final SetNotificationTime setNotificationTime;
  AppNotificationTimePicker({Key? key, required this.setNotificationTime}) : super(key: key);

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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Column(
              children: (parameterMap.keys)
                  .map((key) => ListTile(
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                      title: Text(
                        key,
                        style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                      ),
                      onTap: () => setNotificationTime(parameterMap[key]!)))
                  .toList()),
        )),
      ),
    );
  }
}
