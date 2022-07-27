import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class NoScheduleAvailable extends StatelessWidget {
  final String errorType;
  const NoScheduleAvailable({Key? key, required this.errorType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        padding: const EdgeInsets.all(50.0),
        child: Center(
            child: Text(
          errorType,
          style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 20,
              fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        )),
      ),
    ]);
  }
}
