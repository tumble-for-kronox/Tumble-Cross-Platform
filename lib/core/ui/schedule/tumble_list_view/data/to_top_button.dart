import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ToTopButton extends StatelessWidget {
  final VoidCallback scrollToTop;
  const ToTopButton({super.key, required this.scrollToTop});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(5),
          boxShadow: const <BoxShadow>[BoxShadow(color: Colors.black26, blurRadius: 3, offset: Offset(0, 2))],
        ),
        child: MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          onPressed: scrollToTop,
          visualDensity: VisualDensity.compact,
          splashColor: Colors.grey.shade200,
          child: Icon(
            CupertinoIcons.chevron_up,
            size: 28,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ));
  }
}
