import 'package:flutter/material.dart';
import 'package:tumble/core/theme/data/colors.dart';

void showScaffoldMessage(BuildContext context, String payload) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: const Color.fromARGB(255, 65, 65, 65),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      behavior: SnackBarBehavior.floating,
      content: Text(
        payload,
        style:
            TextStyle(color: CustomColors.lightColors.secondary, fontSize: 13),
        textAlign: TextAlign.left,
      )));
}
