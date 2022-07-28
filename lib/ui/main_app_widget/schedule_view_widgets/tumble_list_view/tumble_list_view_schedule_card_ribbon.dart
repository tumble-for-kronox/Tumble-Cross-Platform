import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ScheduleCardRibbon extends StatelessWidget {
  final String color;
  const ScheduleCardRibbon({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 9, right: 9),
        alignment: Alignment.topRight,
        child: Image(
            width: 50,
            height: 50,
            image: const AssetImage("assets/images/cardBanner.png"),
            color:
                Color(int.parse("ff${color.replaceAll("#", "")}", radix: 16))));
  }
}
