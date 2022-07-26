import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchErrorMessage extends StatelessWidget {
  final String errorType;
  const SearchErrorMessage({Key? key, required this.errorType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        errorType,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onBackground,
          fontSize: 30,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
