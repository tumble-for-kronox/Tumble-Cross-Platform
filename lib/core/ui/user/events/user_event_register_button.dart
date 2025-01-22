import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tumble/core/api/preferences/repository/preference_repository.dart';
import 'package:tumble/core/ui/data/string_constants.dart';
import 'package:tumble/core/api/dependency_injection/get_it.dart';
import 'package:tumble/core/ui/tumble_loading.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UserEventRegisterButton extends StatelessWidget {
  final bool linkToKronox;
  final bool loading;
  final Null Function()? onPressed;

  const UserEventRegisterButton({super.key, required this.loading, required this.linkToKronox, this.onPressed});

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
                            "https://kronox.${getIt<PreferenceRepository>().defaultSchool!.toLowerCase()}.se/aktivitetsanmalan.jsp?";
                        await launchUrlString(urlString);
                      },
                icon: const Icon(CupertinoIcons.person_crop_circle_badge_checkmark),
                label: Text(S.userEvents.openKronoxButton()),
              )
            : TextButton.icon(
                onPressed: loading ? null : onPressed,
                style: ButtonStyle(
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                    backgroundColor: WidgetStateColor.resolveWith((Set<WidgetState> states) =>
                        states.contains(WidgetState.disabled)
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
