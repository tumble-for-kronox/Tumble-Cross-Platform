import 'package:flutter/material.dart';

typedef ToggleDrawerEvent = void Function(Enum eventType);

class TumbleAppDrawerTile extends StatelessWidget {
  final IconData suffixIcon;
  final String drawerTileTitle;
  final String subtitle;
  final Enum eventType;
  final ToggleDrawerEvent drawerEvent;

  const TumbleAppDrawerTile(
      {Key? key,
      required this.suffixIcon,
      required this.drawerTileTitle,
      required this.subtitle,
      required this.eventType,
      required this.drawerEvent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        onPressed: () => drawerEvent(eventType),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: 1,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
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
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: SizedBox(
                width: 35,
                child: Icon(
                  suffixIcon,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
