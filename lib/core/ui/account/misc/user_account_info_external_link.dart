import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tumble/core/ui/data/groups/scaffold_message_types.dart';
import 'package:tumble/core/ui/data/string_constants.dart';
import 'package:tumble/core/ui/scaffold_message.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UserAccountExternalLink extends StatelessWidget {
  final String title;
  final String link;
  final Color color;

  const UserAccountExternalLink({
    Key? key,
    required this.title,
    required this.color,
    required this.link,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      child: MaterialButton(
        minWidth: double.maxFinite,
        height: 55,
        color: Theme.of(context).colorScheme.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        highlightElevation: 2,
        padding: const EdgeInsets.only(right: 10),
        onPressed: () async {
          if (await canLaunchUrlString(link)) {
            await launchUrlString(link);
          } else {
            showScaffoldMessage(context, S.scaffoldMessages.openExternalUrlFailed('Kronox'));
          }
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 10,
              height: 55,
              decoration: BoxDecoration(
                color: color.withOpacity(0.8),
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  title,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                    fontWeight: Theme.of(context).textTheme.titleMedium!.fontWeight,
                  ),
                  maxLines: 1,
                ),
              ),
            ),
            Icon(
              CupertinoIcons.arrow_right_circle,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ],
        ),
      ),
    );
  }
}
