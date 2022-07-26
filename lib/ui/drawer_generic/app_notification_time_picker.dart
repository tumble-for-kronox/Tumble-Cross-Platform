import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef SetNotificationTime = void Function(int time);

class AppNotificationTimePicker extends StatelessWidget {
  final Map<String, int> parameterMap = {
    "15 minutes": 15,
    "30 minutes": 30,
    "1 hour": 60,
    "3 hours": 180
  };
  final SetNotificationTime setNotificationTime;
  AppNotificationTimePicker({Key? key, required this.setNotificationTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 240,
        margin: const EdgeInsets.only(bottom: 30, left: 12, right: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox.expand(
            child: Card(
          elevation: 0,
          color: Theme.of(context).colorScheme.surface,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Column(
              children: (parameterMap.keys)
                  .map((key) => ListTile(
                      title: Text(
                        key,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      onTap: () => setNotificationTime(parameterMap[key]!)))
                  .toList()),
        )),
      ),
    );
  }
}
