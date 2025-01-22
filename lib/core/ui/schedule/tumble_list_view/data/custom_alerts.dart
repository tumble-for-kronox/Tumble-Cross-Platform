import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tumble/core/api/backend/response_types/runtime_error_type.dart';
import 'package:tumble/core/ui/data/string_constants.dart';

typedef NavigateToSearchFromView = void Function();

class CustomAlertDialog {
  static AlertDialog noBookMarkedSchedules(
    BuildContext context,
    NavigateToSearchFromView navigateToSearchFromView,
  ) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(25),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
      content: SizedBox(
        height: 160,
        child: Column(children: [
          Text(S.popUps.scheduleHelpFirstLine(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface, fontSize: 16, fontWeight: FontWeight.w500)),
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
                  color: Theme.of(context).colorScheme.onSurface, fontSize: 16, fontWeight: FontWeight.w400))
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
    BuildContext context,
    NavigateToSearchFromView navigateToSearchFromView,
  ) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(25),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
      content: SizedBox(
        height: 160,
        child: Column(children: [
          Text(S.popUps.scheduleIsEmptyTitle(),
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface, fontSize: 16, fontWeight: FontWeight.w400)),
          const SizedBox(
            height: 30,
          ),
          Text(S.popUps.scheduleIsEmptyBody(),
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface, fontSize: 16, fontWeight: FontWeight.w400))
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

  static AlertDialog programFetchError(
    BuildContext context,
    NavigateToSearchFromView navigateToSearchFromView,
  ) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
      contentPadding: const EdgeInsets.all(25),
      content: SizedBox(
        height: 95,
        child: Column(children: [
          Text(S.popUps.scheduleFetchError(),
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface, fontSize: 16, fontWeight: FontWeight.w400)),
          const SizedBox(
            height: 30,
          ),
          Text(S.general.tryAgain(),
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface, fontSize: 15, fontWeight: FontWeight.w400))
        ]),
      ),
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

  static AlertDialog scheduleCacheFetchError(
    BuildContext context,
    NavigateToSearchFromView navigateToSearchFromView,
  ) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
      contentPadding: const EdgeInsets.all(25),
      content: SizedBox(
        height: 95,
        child: Column(children: [
          Text(RuntimeErrorType.noCachedSchedule(),
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface, fontSize: 16, fontWeight: FontWeight.w400)),
          const SizedBox(
            height: 30,
          ),
          Text(S.general.tryAgain(),
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface, fontSize: 15, fontWeight: FontWeight.w400))
        ]),
      ),
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

  static AlertDialog resourceNotGettable(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
      content: SizedBox(
        height: 210,
        child: Column(children: [
          Text(S.popUps.resourceFetchErrorTitle(),
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface, fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(
            height: 20,
          ),
          Text(S.popUps.resourceFetchErrorBody(),
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface, fontSize: 16, fontWeight: FontWeight.w400))
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
