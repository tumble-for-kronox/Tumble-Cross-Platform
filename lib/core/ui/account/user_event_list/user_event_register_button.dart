import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tumble/core/theme/data/colors.dart';
import 'package:tumble/core/ui/data/string_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/dependency_injection/get_it_instances.dart';
import 'package:tumble/core/shared/preference_types.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UserEventRegisterButton extends StatelessWidget {
  final bool linkToKronox;
  final Null Function()? onPressed;

  const UserEventRegisterButton({Key? key, required this.linkToKronox, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        decoration:
            const BoxDecoration(color: CustomColors.orangePrimary, borderRadius: BorderRadius.all(Radius.circular(10))),
        child: linkToKronox
            ? TextButton.icon(
                onPressed: () async {
                  String urlString =
                      "https://kronox.${getIt<SharedPreferences>().getString(PreferenceTypes.school)!.toLowerCase()}.se/aktivitetsanmalan.jsp?";
                  await launchUrlString(urlString);
                },
                icon: const Icon(CupertinoIcons.person_crop_circle_badge_checkmark),
                label: Text(S.userEvents.openKronoxButton()),
              )
            : TextButton.icon(
                onPressed: onPressed,
                icon: Icon(CupertinoIcons.person_crop_circle_badge_checkmark,
                    color: Theme.of(context).colorScheme.onPrimary),
                label: Text(
                  S.userEvents.registerButton(),
                  style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                ),
              ));
  }
}
