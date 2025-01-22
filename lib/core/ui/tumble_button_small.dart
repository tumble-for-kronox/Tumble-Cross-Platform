import 'package:flutter/material.dart';
import 'package:tumble/core/ui/tumble_loading.dart';

class TumbleButtonSmall extends StatelessWidget {
  final void Function()? onPressed;
  final IconData prefixIcon;
  final String text;
  final bool loading;

  const TumbleButtonSmall({
    super.key,
    this.onPressed,
    required this.prefixIcon,
    required this.text,
    required this.loading,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 40,
        child: TextButton.icon(
          onPressed: loading ? null : onPressed,
          style: ButtonStyle(
              shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              backgroundColor: WidgetStateColor.resolveWith((Set<WidgetState> states) =>
                  states.contains(WidgetState.disabled)
                      ? Theme.of(context).colorScheme.primary.withOpacity(0.5)
                      : Theme.of(context).colorScheme.primary)),
          icon: loading
              ? TumbleLoading(
                  size: 18,
                  color: Theme.of(context).colorScheme.onPrimary,
                )
              : Icon(
                  prefixIcon,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
          label: Text(
            text,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ));
  }
}
