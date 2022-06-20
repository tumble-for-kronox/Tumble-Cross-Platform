import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class NoScheduleAvailable extends StatelessWidget {
  const NoScheduleAvailable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        padding: const EdgeInsets.all(50.0),
        child: Center(
            child: AnimatedTextKit(
          totalRepeatCount: 1,
          animatedTexts: [
            TyperAnimatedText(
              "Nothing to find here...",
              speed: const Duration(milliseconds: 60),
              textStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            )
          ],
        )),
      ),
      Center(
          child: TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text(
          'Take me back',
          style: TextStyle(fontSize: 17),
        ),
      ))
    ]);
  }
}
