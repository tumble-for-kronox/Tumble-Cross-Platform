import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/navigation/app_navigator.dart';
import 'package:tumble/core/ui/data/string_constants.dart';
import 'package:tumble/core/ui/user/cubit/user_event_cubit.dart';

typedef NavigateToSearchFromView = void Function();

class CustomAlertDialog {
  static AlertDialog noBookMarkedSchedules(
      BuildContext context, NavigateToSearchFromView navigateToSearchFromView, AppNavigator navigator) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(25),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
      content: SizedBox(
        height: 160,
        child: Column(children: [
          Text(S.popUps.scheduleHelpFirstLine(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground, fontSize: 16, fontWeight: FontWeight.w500)),
          const SizedBox(
            height: 20,
          ),
          const Icon(
            CupertinoIcons.bookmark,
            size: 20,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(S.popUps.scheduleHelpSecondLine(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground, fontSize: 16, fontWeight: FontWeight.w400))
        ]),
      ),
      actions: [
        CupertinoDialogAction(
          child: Text(S.general.understood(),
              style:
                  TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 15, fontWeight: FontWeight.w400)),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
        CupertinoDialogAction(
          child: Text(S.general.toSearch(),
              style:
                  TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 15, fontWeight: FontWeight.w400)),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
            navigateToSearchFromView();
          },
        )
      ],
    );
  }

  static AlertDialog previewContainsNoViews(
      BuildContext context, NavigateToSearchFromView navigateToSearchFromView, AppNavigator navigator) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(25),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
      content: SizedBox(
        height: 160,
        child: Column(children: [
          Text(S.popUps.scheduleIsEmptyTitle(),
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground, fontSize: 16, fontWeight: FontWeight.w400)),
          const SizedBox(
            height: 30,
          ),
          Text(S.popUps.scheduleIsEmptyBody(),
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground, fontSize: 16, fontWeight: FontWeight.w400))
        ]),
      ),
      actions: [
        CupertinoDialogAction(
          child: Text(S.general.ok(),
              style:
                  TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 15, fontWeight: FontWeight.w400)),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
      ],
    );
  }

  static AlertDialog fetchError(
      BuildContext context, NavigateToSearchFromView navigateToSearchFromView, AppNavigator navigator) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
      contentPadding: const EdgeInsets.all(25),
      content: Column(children: [
        Text(S.popUps.resourceFetchErrorTitle(),
            style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground, fontSize: 16, fontWeight: FontWeight.w400)),
        const SizedBox(
          height: 20,
        ),
        Text(S.general.tryAgain(),
            style:
                TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: 15, fontWeight: FontWeight.w400))
      ]),
      actions: [
        CupertinoDialogAction(
          child: Text(S.general.toSearch(),
              style:
                  TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 15, fontWeight: FontWeight.w400)),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
            navigateToSearchFromView();
          },
        )
      ],
    );
  }

  static AlertDialog automaticExamSignupWarning(BuildContext context, bool value) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
      content: SizedBox(
        height: 210,
        child: Column(children: [
          Text(S.popUps.autoSignupTitle(),
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground, fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(
            height: 20,
          ),
          Text(S.popUps.autoSignupBody(),
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground, fontSize: 16, fontWeight: FontWeight.w400))
        ]),
      ),
      actions: [
        CupertinoDialogAction(
          child: Text(
            S.general.cancel(),
            style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 15, fontWeight: FontWeight.w400),
          ),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
        CupertinoDialogAction(
          child: Text(S.general.understood(),
              style:
                  TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 15, fontWeight: FontWeight.w400)),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
            BlocProvider.of<UserEventCubit>(context).autoSignupToggle(value);
          },
        )
      ],
    );
  }

  static AlertDialog resourceNotGettable(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
      content: SizedBox(
        height: 210,
        child: Column(children: [
          Text(S.popUps.resourceFetchErrorTitle(),
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground, fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(
            height: 20,
          ),
          Text(S.popUps.resourceFetchErrorBody(),
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground, fontSize: 16, fontWeight: FontWeight.w400))
        ]),
      ),
      actions: [
        CupertinoDialogAction(
          child: Text(
            S.general.ok(),
            style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 15, fontWeight: FontWeight.w400),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
