import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tumble/core/ui/data/string_constants.dart';

class UserEventUnregisterButton extends StatelessWidget {
  final Null Function() onPressed;

  const UserEventUnregisterButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: const Icon(CupertinoIcons.person_crop_circle_badge_checkmark),
      label: Text(S.userEvents.unregisterButton()),
    );
  }
}
