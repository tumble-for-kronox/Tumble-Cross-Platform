import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/ui/data/string_constants.dart';
import 'package:tumble/core/ui/app_switch/misc/tumble_drag_pill.dart';
import 'package:tumble/core/ui/schedule/cancel_button.dart';

typedef SetNotificationTime = void Function(int time);

class AppNotificationTimePicker extends StatelessWidget {
  final Map<String, int> parameterMap;
  final SetNotificationTime setNotificationTime;
  final int currentNotificationTime;

  const AppNotificationTimePicker(
      {Key? key,
      required this.setNotificationTime,
      required this.parameterMap,
      required this.currentNotificationTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: 240,
          margin: const EdgeInsets.only(bottom: 25, left: 12, right: 12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              SizedBox.expand(
                  child: Card(
                elevation: 0,
                color: Theme.of(context).colorScheme.surface,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                    children: (parameterMap.keys)
                        .map((key) => ListTile(
                            leading:
                                parameterMap[key] == currentNotificationTime
                                    ? const Icon(CupertinoIcons.check_mark)
                                    : null,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            title: Text(
                              key,
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onSurface),
                            ),
                            onTap: () =>
                                setNotificationTime(parameterMap[key]!)))
                        .toList()),
              )),
              TumbleDragPill(
                  barColor:
                      Theme.of(context).colorScheme.background.contrastColor())
            ],
          ),
        ),
        const CancelButton()
      ],
    );
  }
}
