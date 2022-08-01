import 'package:flutter/material.dart';

void showScaffoldMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      behavior: SnackBarBehavior.floating,
      content: Text(message)));
}
