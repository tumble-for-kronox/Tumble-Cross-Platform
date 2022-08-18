import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ScheduleCardRibbon extends StatelessWidget {
  final Color color;
  const ScheduleCardRibbon({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 0, right: 0),
      alignment: Alignment.topLeft,
      child: Transform.rotate(
        angle: -pi / 2,
        child: Image(
          width: 60,
          height: 60,
          image: const AssetImage("assets/images/cardBanner.png"),
          color: color,
        ),
      ),
    );
  }
}
