import 'package:flutter/material.dart';

class TumbleSettingsSection extends StatelessWidget {
  final List<Widget> tiles;
  final String title;

  const TumbleSettingsSection(
      {Key? key, required this.tiles, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: tiles,
            ),
          ),
        ],
      ),
    );
  }
}
