import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'dart:math' as math;

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
      height: 80,
      width: 100,
      child: MaterialButton(
        padding: EdgeInsets.zero,
        color: color,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(7.5)),
        ),
        highlightElevation: 2,
        onPressed: () async {
          await launchUrlString(link);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.rotate(
              angle: 180 * math.pi / 180,
              child: IconButton(
                icon: Icon(
                  icon,
                  color: Colors.white,
                ),
                onPressed: null,
              ),
            ),
            Container(
                padding: const EdgeInsets.only(bottom: 7.5),
                child: Text(
                  title,
                  style: const TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
