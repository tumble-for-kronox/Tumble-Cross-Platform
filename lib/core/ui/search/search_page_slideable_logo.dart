import 'package:flutter/material.dart';

class SlideableLogo extends StatelessWidget {
  final bool focused;
  const SlideableLogo({super.key, required this.focused});

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
        duration: const Duration(milliseconds: 200),
        child: AnimatedOpacity(
          opacity: focused ? 0 : 1,
          duration: const Duration(milliseconds: 150),
          child: SizedOverflowBox(
            alignment: Alignment.center,
            size: Size(double.infinity, (focused ? 0 : 300)),
            child: Align(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    height: 45,
                    image: const AssetImage("assets/images/ic_launcher.png"),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "TUMBLE",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 32,
                      letterSpacing: 3,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
