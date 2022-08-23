import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/navigation/app_navigator.dart';

import '../../../login/cubit/auth_cubit.dart';

typedef NavigateToSearchFromView = void Function();

class CustomCupertinoAlerts {
  static CupertinoAlertDialog noBookMarkedSchedules(
      BuildContext context, NavigateToSearchFromView navigateToSearchFromView, AppNavigator navigator) {
    return CupertinoAlertDialog(
      content: Column(children: [
        Text("Schedules can be bookmarked with this icon",
            style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground, fontSize: 15, fontWeight: FontWeight.w600)),
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
        Text("It will appear in the top left corner once you've searched for and opened your schedule",
            style:
                TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: 15, fontWeight: FontWeight.w600))
      ]),
      actions: [
        CupertinoDialogAction(
          child: Text("I understand",
              style:
                  TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 13, fontWeight: FontWeight.w600)),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
        CupertinoDialogAction(
          child: Text("Take me to search",
              style:
                  TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 13, fontWeight: FontWeight.w600)),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
            navigateToSearchFromView();
          },
        )
      ],
    );
  }

  static CupertinoAlertDialog scheduleContainsNoViews(
      BuildContext context, NavigateToSearchFromView navigateToSearchFromView, AppNavigator navigator) {
    return CupertinoAlertDialog(
      content: Column(children: [
        Text("This schedule appears to be empty but still in the Kronox database",
            style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground, fontSize: 15, fontWeight: FontWeight.w600)),
        const SizedBox(
          height: 20,
        ),
        Text(
            "Kronox stores schedules even if they do not contain any data, so our searches might ocassionally find emtpy schedules",
            style:
                TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: 14, fontWeight: FontWeight.w600))
      ]),
      actions: [
        CupertinoDialogAction(
          child: Text("Ok",
              style:
                  TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 13, fontWeight: FontWeight.w600)),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
        CupertinoDialogAction(
          child: Text("Take me to search",
              style:
                  TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 13, fontWeight: FontWeight.w600)),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
            navigateToSearchFromView();
          },
        )
      ],
    );
  }

  static CupertinoAlertDialog fetchError(
      BuildContext context, NavigateToSearchFromView navigateToSearchFromView, AppNavigator navigator) {
    return CupertinoAlertDialog(
      content: Column(children: [
        Text("There was an error retrieveing this schedule",
            style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground, fontSize: 15, fontWeight: FontWeight.w600)),
        const SizedBox(
          height: 20,
        ),
        Text("Please try again",
            style:
                TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: 14, fontWeight: FontWeight.w600))
      ]),
      actions: [
        CupertinoDialogAction(
          child: Text("Take me to search",
              style:
                  TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 13, fontWeight: FontWeight.w600)),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
            navigateToSearchFromView();
          },
        )
      ],
    );
  }

  static CupertinoAlertDialog automaticExamSignupWarning(BuildContext context, bool value) {
    return CupertinoAlertDialog(
      content: Column(children: [
        Text("Automatic exam registration should be used with caution!",
            style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground, fontSize: 15, fontWeight: FontWeight.w600)),
        const SizedBox(
          height: 20,
        ),
        Text(
            "Things can go wrong and so it is still your own responsibility to make sure you are signed up for your exams. If an exam requires you to choose a location you cannot be automatically signed up, similarly you must manually enable support if you need it",
            style:
                TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: 14, fontWeight: FontWeight.w600))
      ]),
      actions: [
        CupertinoDialogAction(
          child: Text(
            "Cancel",
            style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 13, fontWeight: FontWeight.w600),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        CupertinoDialogAction(
          child: Text("Understood",
              style:
                  TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 13, fontWeight: FontWeight.w600)),
          onPressed: () {
            BlocProvider.of<AuthCubit>(context).autoSignupToggle(value);
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
