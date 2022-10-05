import 'package:flutter/material.dart';

class TumbleDragPill extends StatelessWidget {
  final Color barColor;
  const TumbleDragPill({
    Key? key,
    required this.barColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.only(top: 5),
        child: Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: barColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      );
}
