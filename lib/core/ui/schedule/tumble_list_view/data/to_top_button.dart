import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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
        borderRadius: BorderRadius.circular(5),
        boxShadow: const <BoxShadow>[BoxShadow(color: Colors.black26, blurRadius: 3, offset: Offset(0, 2))],
      ),
      child: MaterialButton(
          onPressed: scrollToTop,
          visualDensity: VisualDensity.compact,
          splashColor: Colors.grey.shade200,
          child: Column(
            children: [
              Icon(
                Icons.keyboard_arrow_up_sharp,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  S.listViewPage.toTopButton(),
                  style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                ),
              )
            ],
          )),
    );
  }
}
