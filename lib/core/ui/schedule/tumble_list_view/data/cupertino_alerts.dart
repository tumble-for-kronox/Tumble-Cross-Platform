import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/navigation/app_navigator.dart';
import 'package:tumble/core/ui/data/string_constants.dart';

import '../../../login/cubit/auth_cubit.dart';

typedef NavigateToSearchFromView = void Function();

class CustomCupertinoAlerts {
  static CupertinoAlertDialog noBookMarkedSchedules(
      BuildContext context, NavigateToSearchFromView navigateToSearchFromView, AppNavigator navigator) {
    return CupertinoAlertDialog(
      content: Column(children: [
        Text(S.popUps.scheduleHelpFirstLine(),
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
        Text(S.popUps.scheduleHelpSecondLine(),
            style:
                TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: 15, fontWeight: FontWeight.w600))
      ]),
      actions: [
        CupertinoDialogAction(
          child: Text(S.general.understood(),
              style:
                  TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 13, fontWeight: FontWeight.w600)),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
        CupertinoDialogAction(
          child: Text(S.general.toSearch(),
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
        Text(S.popUps.scheduleIsEmptyTitle(),
            style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground, fontSize: 15, fontWeight: FontWeight.w600)),
        const SizedBox(
          height: 20,
        ),
        Text(S.popUps.scheduleIsEmptyBody(),
            style:
                TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: 14, fontWeight: FontWeight.w600))
      ]),
      actions: [
        CupertinoDialogAction(
          child: Text(S.general.ok(),
              style:
                  TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 13, fontWeight: FontWeight.w600)),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
        CupertinoDialogAction(
          child: Text(S.general.toSearch(),
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
        Text(S.popUps.scheduleFetchError(),
            style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground, fontSize: 15, fontWeight: FontWeight.w600)),
        const SizedBox(
          height: 20,
        ),
        Text(S.general.tryAgain(),
            style:
                TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: 14, fontWeight: FontWeight.w600))
      ]),
      actions: [
        CupertinoDialogAction(
          child: Text(S.general.toSearch(),
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
        Text(S.popUps.autoSignupTitle(),
            style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground, fontSize: 15, fontWeight: FontWeight.w600)),
        const SizedBox(
          height: 20,
        ),
        Text(S.popUps.autoSignupBody(),
            style:
                TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: 14, fontWeight: FontWeight.w600))
      ]),
      actions: [
        CupertinoDialogAction(
          child: Text(
            S.general.cancel(),
            style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 13, fontWeight: FontWeight.w600),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        CupertinoDialogAction(
          child: Text(S.general.understood(),
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
