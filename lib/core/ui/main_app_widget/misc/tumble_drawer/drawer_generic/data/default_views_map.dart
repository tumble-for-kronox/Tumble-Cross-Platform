import 'package:flutter/cupertino.dart';
import 'package:tumble/core/shared/view_types.dart';

class IconAndTitleSet {
  static final Map<String, Map<int, Icon>> views = {
    "List": <int, Icon>{
      ScheduleViewTypes.list: const Icon(
        CupertinoIcons.collections,
      )
    },
    "Week": <int, Icon>{
      ScheduleViewTypes.week: const Icon(
        CupertinoIcons.list_bullet_indent,
      )
    },
    "Calendar": <int, Icon>{
      ScheduleViewTypes.calendar: const Icon(
        CupertinoIcons.calendar_today,
      )
    }
  };

  static final Map<String, Icon> themes = {
    "Dark theme": const Icon(
      CupertinoIcons.moon,
    ),
    "Light theme": const Icon(CupertinoIcons.sun_max),
    "System theme": const Icon(
      CupertinoIcons.device_phone_portrait,
    )
  };
}
