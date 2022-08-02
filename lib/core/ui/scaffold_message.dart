import 'package:flutter/material.dart';

void showScaffoldMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      behavior: SnackBarBehavior.floating,
      content: Text(
        message,
        style: TextStyle(color: Theme.of(context).colorScheme.background),
        textAlign: TextAlign.center,
      )));
}
