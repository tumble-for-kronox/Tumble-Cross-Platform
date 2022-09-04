import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class TumbleLoading extends StatelessWidget {
  const TumbleLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SpinKitThreeBounce(
        color: Theme.of(context).colorScheme.primary,
        size: 25,
      );
}
