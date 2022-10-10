import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tumble/core/ui/data/string_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/api/dependency_injection/get_it.dart';
import 'package:tumble/core/shared/preference_types.dart';
import 'package:tumble/core/ui/tumble_loading.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UserEventRegisterButton extends StatelessWidget {
  final bool linkToKronox;
  final bool loading;
  final Null Function()? onPressed;

  const UserEventRegisterButton({Key? key, required this.loading, required this.linkToKronox, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 40,
        child: linkToKronox
            ? TextButton.icon(
                onPressed: loading
                    ? null
                    : () async {
                        String urlString =
                            "https://kronox.${getIt<SharedPreferences>().getString(PreferenceTypes.school)!.toLowerCase()}.se/aktivitetsanmalan.jsp?";
                        await launchUrlString(urlString);
                      },
                icon: const Icon(CupertinoIcons.person_crop_circle_badge_checkmark),
                label: Text(S.userEvents.openKronoxButton()),
              )
            : TextButton.icon(
                onPressed: loading ? null : onPressed,
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                    backgroundColor: MaterialStateColor.resolveWith((Set<MaterialState> states) =>
                        states.contains(MaterialState.disabled)
                            ? Theme.of(context).colorScheme.primary.withOpacity(0.5)
                            : Theme.of(context).colorScheme.primary)),
                icon: loading
                    ? TumbleLoading(
                        size: 18,
                        color: Theme.of(context).colorScheme.onPrimary,
                      )
                    : Icon(CupertinoIcons.person_crop_circle_badge_checkmark,
                        color: Theme.of(context).colorScheme.onPrimary),
                label: Text(
                  S.userEvents.registerButton(),
                  style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                ),
              ));
  }
}
