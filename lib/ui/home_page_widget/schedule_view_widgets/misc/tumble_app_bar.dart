import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TumbleAppBar extends StatefulWidget implements PreferredSizeWidget {
  const TumbleAppBar({Key? key}) : super(key: key);

  @override
  State<TumbleAppBar> createState() => _TumbleAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class _TumbleAppBarState extends State<TumbleAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(CupertinoIcons.gear),
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
    );
  }
}
