import 'package:flutter/material.dart';

class TumbleButton extends StatelessWidget {
  final void Function() onPressed;
  final IconData prefixIcon;
  final String text;

  const TumbleButton({
    Key? key,
    required this.onPressed,
    required this.prefixIcon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: MaterialButton(
        onPressed: onPressed,
        highlightElevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Theme.of(context).colorScheme.primary,
        child: Row(
          children: [
            Icon(
              prefixIcon,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            Expanded(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
