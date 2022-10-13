import 'package:flutter/material.dart';

class SearchErrorMessage extends StatelessWidget {
  final String errorType;
  const SearchErrorMessage({Key? key, required this.errorType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        padding: const EdgeInsets.all(50.0),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              errorType,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        )),
      ),
    ]);
  }
}
