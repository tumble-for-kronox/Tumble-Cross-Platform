import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SlideableLogo extends StatelessWidget {
  final bool focused;
  const SlideableLogo({Key? key, required this.focused}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
        duration: const Duration(milliseconds: 200),
        child: AnimatedOpacity(
          opacity: focused ? 0 : 1,
          duration: const Duration(milliseconds: 150),
          child: SizedOverflowBox(
            size: Size(double.infinity, (focused ? 0 : 300)),
            child: Image(
              height: 150,
              image: const AssetImage("assets/images/tumbleAppLogo.png"),
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ));
  }
}
