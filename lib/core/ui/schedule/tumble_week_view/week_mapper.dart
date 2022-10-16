import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tumble/core/models/ui_models/week_model.dart';
import 'package:tumble/core/ui/schedule/tumble_week_view/tumble_day_of_week_container.dart';

class WeekMapper extends StatelessWidget {
  final Week week;
  const WeekMapper({Key? key, required this.week}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        padding: const EdgeInsets.only(top: 35),
        child: ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              end: Alignment.topCenter,
              begin: Alignment.bottomCenter,
              colors: [Colors.white, Colors.white.withOpacity(0.05)],
              stops: [
                .95,
                1,
              ],
              tileMode: TileMode.mirror,
            ).createShader(bounds);
          },
          blendMode: BlendMode.dstIn,
          child: ListView(
              padding: const EdgeInsets.only(top: 10),
              children: week.days
                  .map((day) => TumbleDayOfWeekContainer(
                        day: day,
                      ))
                  .toList()),
        ),
      ),
    );
  }
}
