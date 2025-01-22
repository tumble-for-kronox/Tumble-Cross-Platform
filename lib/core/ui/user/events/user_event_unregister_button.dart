import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tumble/core/ui/data/string_constants.dart';
import 'package:tumble/core/ui/tumble_loading.dart';

class UserEventUnregisterButton extends StatelessWidget {
  final bool loading;
  final Null Function() onPressed;

  const UserEventUnregisterButton({super.key, required this.loading, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextButton.icon(
        style: ButtonStyle(
            shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
            backgroundColor: WidgetStateColor.resolveWith((Set<WidgetState> states) =>
                states.contains(WidgetState.disabled)
                    ? Theme.of(context).colorScheme.primary.withOpacity(0.5)
                    : Theme.of(context).colorScheme.primary)),
        onPressed: loading ? null : onPressed,
        icon: loading
            ? TumbleLoading(
                size: 18,
                color: Theme.of(context).colorScheme.onPrimary,
              )
            : Icon(
                CupertinoIcons.person_crop_circle_badge_checkmark,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
        label: Text(
          S.userEvents.unregisterButton(),
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
    );
  }
}
