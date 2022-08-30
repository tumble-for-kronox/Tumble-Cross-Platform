import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tumble/core/ui/data/string_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/dependency_injection/get_it_instances.dart';
import 'package:tumble/core/shared/preference_types.dart';
import 'package:tumble/core/ui/scaffold_message.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UserEventRegisterButton extends StatelessWidget {
  final bool linkToKronox;
  final Null Function()? onPressed;

  const UserEventRegisterButton(
      {Key? key, required this.linkToKronox, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return linkToKronox
        ? TextButton.icon(
            onPressed: () async {
              String urlString =
                  "https://kronox.${getIt<SharedPreferences>().getString(PreferenceTypes.school)!.toLowerCase()}.se/aktivitetsanmalan.jsp?";
              if (await canLaunchUrlString(urlString)) {
                await launchUrlString(urlString,
                    mode: LaunchMode.externalApplication);
              } else {
                showScaffoldMessage(context,
                    S.scaffoldMessages.openExternalUrlFailed('Kronox'));
              }
            },
            icon: const Icon(CupertinoIcons.person_crop_circle_badge_checkmark),
            label: const Text("Open Kronox"),
          )
        : TextButton.icon(
            onPressed: onPressed,
            icon: const Icon(CupertinoIcons.person_crop_circle_badge_checkmark),
            label: const Text("Register"),
          );
  }
}
