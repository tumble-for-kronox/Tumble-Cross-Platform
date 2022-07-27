import 'package:flutter/material.dart';

typedef ToggleDrawerEvent = void Function(Enum eventType);

class TumbleAppDrawerTile extends StatelessWidget {
  final IconData prefixIcon;
  final String drawerTileTitle;
  final String subtitle;
  final Enum eventType;
  final ToggleDrawerEvent drawerEvent;

  const TumbleAppDrawerTile(
      {Key? key,
      required this.prefixIcon,
      required this.drawerTileTitle,
      required this.subtitle,
      required this.eventType,
      required this.drawerEvent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: MaterialButton(
        padding: const EdgeInsets.all(0),
        onPressed: () => drawerEvent(eventType),
        child: Row(
          children: [
            SizedBox(
              width: 35,
              child: Icon(
                prefixIcon,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    drawerTileTitle,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Flexible(
                  child: Text(
                    subtitle,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
