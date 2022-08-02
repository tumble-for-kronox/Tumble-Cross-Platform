import 'package:flutter/material.dart';
import 'package:tumble/core/theme/data/colors.dart';

void showScaffoldMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Color.fromARGB(255, 65, 65, 65),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      behavior: SnackBarBehavior.floating,
      content: Text(
        message,
        style: TextStyle(color: CustomColors.lightColors.secondary),
        textAlign: TextAlign.center,
      )));
}
