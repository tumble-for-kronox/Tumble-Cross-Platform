import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UserAccountExternalLink extends StatelessWidget {
  final String title;
  final String link;
  final Color color;
  final IconData icon;

  const UserAccountExternalLink({
    Key? key,
    required this.title,
    required this.color,
    required this.link,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 100,
      child: MaterialButton(
        padding: EdgeInsets.zero,
        color: color,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        highlightElevation: 2,
        onPressed: () async {
          await launchUrlString(link);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            Text(
              title,
              style: const TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
