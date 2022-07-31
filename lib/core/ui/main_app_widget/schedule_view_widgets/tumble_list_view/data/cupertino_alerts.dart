import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tumble/core/navigation/app_navigator.dart';

typedef NavigateToSearchFromView = void Function();

class CustomCupertinoAlerts {
  static CupertinoAlertDialog noBookMarkedSchedules(
      BuildContext context,
      NavigateToSearchFromView navigateToSearchFromView,
      AppNavigator navigator) {
    return CupertinoAlertDialog(
      content: Column(children: [
        Text("Schedules can be bookmarked with this icon",
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondary,
                fontSize: 15,
                fontWeight: FontWeight.w600)),
        const SizedBox(
          height: 15,
        ),
        const Icon(
          CupertinoIcons.bookmark,
          size: 20,
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
            "It will appear in the top left corner once you've searched for and opened your schedule",
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondary,
                fontSize: 15,
                fontWeight: FontWeight.w600))
      ]),
      actions: [
        CupertinoDialogAction(
          child: Text("I understand",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600)),
          onPressed: () {
            navigator.pop();
          },
        ),
        CupertinoDialogAction(
          child: Text("Take me to search",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600)),
          onPressed: () {
            navigator.pop();
            navigateToSearchFromView();
          },
        )
      ],
    );
  }

  static CupertinoAlertDialog scheduleContainsNoViews(
      BuildContext context,
      NavigateToSearchFromView navigateToSearchFromView,
      AppNavigator navigator) {
    return CupertinoAlertDialog(
      content: Column(children: [
        Text(
            "This schedule appears to be empty but still in the Kronox database",
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondary,
                fontSize: 15,
                fontWeight: FontWeight.w600)),
        const SizedBox(
          height: 20,
        ),
        Text(
            "Kronox stores schedules even if they do not contain any data, so our searches might ocassionally find emtpy schedules",
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondary,
                fontSize: 14,
                fontWeight: FontWeight.w600))
      ]),
      actions: [
        CupertinoDialogAction(
          child: Text("Ok",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600)),
          onPressed: () {
            navigator.pop();
          },
        ),
        CupertinoDialogAction(
          child: Text("Take me to search",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600)),
          onPressed: () {
            navigator.pop();
            navigateToSearchFromView();
          },
        )
      ],
    );
  }

  static CupertinoAlertDialog fetchError(
      BuildContext context,
      NavigateToSearchFromView navigateToSearchFromView,
      AppNavigator navigator) {
    return CupertinoAlertDialog(
      content: Column(children: [
        Text("There was an error retrieveing this schedule",
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondary,
                fontSize: 15,
                fontWeight: FontWeight.w600)),
        const SizedBox(
          height: 20,
        ),
        Text("Please try again",
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondary,
                fontSize: 14,
                fontWeight: FontWeight.w600))
      ]),
      actions: [
        CupertinoDialogAction(
          child: Text("Take me to search",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600)),
          onPressed: () {
            navigator.pop();
            navigateToSearchFromView();
          },
        )
      ],
    );
  }
}
