import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class TumbleLoading extends StatelessWidget {
  final Color? color;
  final double size;

  const TumbleLoading({Key? key, this.color, this.size = 25}) : super(key: key);

  @override
  Widget build(BuildContext context) => SpinKitThreeBounce(
        color: color ?? Theme.of(context).colorScheme.primary,
        size: size,
      );
}
