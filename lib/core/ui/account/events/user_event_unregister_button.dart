import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tumble/core/theme/data/colors.dart';
import 'package:tumble/core/ui/data/string_constants.dart';

class UserEventUnregisterButton extends StatelessWidget {
  final Null Function() onPressed;

  const UserEventUnregisterButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration:
          const BoxDecoration(color: CustomColors.orangePrimary, borderRadius: BorderRadius.all(Radius.circular(10))),
      child: TextButton.icon(
        onPressed: onPressed,
        icon: Icon(
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
