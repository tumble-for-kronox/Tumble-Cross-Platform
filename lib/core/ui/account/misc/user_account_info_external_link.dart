import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tumble/core/ui/data/scaffold_message_types.dart';
import 'package:tumble/core/ui/scaffold_message.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UserAccountExternalLink extends StatelessWidget {
  final String title;
  final String link;
  final Color color;

  const UserAccountExternalLink({Key? key, required this.title, required this.color, required this.link})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.maxFinite,
      height: 55,
      color: color.withOpacity(0.8),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      highlightElevation: 2,
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      onPressed: () async {
        if (await canLaunchUrlString(link)) {
          await launchUrlString(link);
        } else {
          showScaffoldMessage(context, ScaffoldMessageType.openExternalUrlFailed('Kronox'));
        }
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              overflow: TextOverflow.ellipsis,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
          ),
          const Icon(
            CupertinoIcons.arrow_right_circle,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
