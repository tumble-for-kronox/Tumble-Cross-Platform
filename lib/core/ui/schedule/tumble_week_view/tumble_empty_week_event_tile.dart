import 'package:flutter/material.dart';
import 'package:tumble/core/ui/data/string_constants.dart';

class TumbleEmptyWeekEventTile extends StatelessWidget {
  const TumbleEmptyWeekEventTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 2.5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(2.5),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Colors.black26,
            blurRadius: .5,
            offset: Offset(0, .5),
          )
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: 5,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(2), bottomLeft: Radius.circular(2)),
              color: Colors.grey.shade400,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 7),
            child: Text(
              S.weekViewPage.noActivities(),
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
