import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tumble/core/ui/data/string_constants.dart';

class ToTopButton extends StatelessWidget {
  final VoidCallback scrollToTop;
  const ToTopButton({Key? key, required this.scrollToTop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(7.5),
          boxShadow: const <BoxShadow>[BoxShadow(color: Colors.black26, blurRadius: 3, offset: Offset(0, 2))],
        ),
        child: MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.5),
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
