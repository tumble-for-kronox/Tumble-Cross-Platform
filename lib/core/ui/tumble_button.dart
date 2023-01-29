import 'package:flutter/material.dart';
import 'package:tumble/core/ui/tumble_loading.dart';

class TumbleButton extends StatelessWidget {
  final void Function() onPressed;
  final IconData prefixIcon;
  final String text;
  final bool loading;

  const TumbleButton({
    Key? key,
    required this.onPressed,
    required this.prefixIcon,
    required this.text,
    required this.loading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: MaterialButton(
        onPressed: onPressed,
        highlightElevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.5)),
        color: Theme.of(context).colorScheme.primary,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            loading
                ? TumbleLoading(
                    color: Theme.of(context).colorScheme.onPrimary,
                  )
                : Icon(
                    prefixIcon,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
            const SizedBox(
              width: 10,
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
