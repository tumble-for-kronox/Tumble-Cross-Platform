import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TumbleAppBar extends StatefulWidget implements PreferredSizeWidget {
  final VoidCallback? navigateToSearch;
  final VoidCallback? toggleFavorite;
  const TumbleAppBar({Key? key, this.navigateToSearch, this.toggleFavorite})
      : super(key: key);

  @override
  State<TumbleAppBar> createState() => _TumbleAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class _TumbleAppBarState extends State<TumbleAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: <Widget>[
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.navigateToSearch != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: widget.toggleFavorite,
                            icon: const Icon(CupertinoIcons.bookmark)),
                        IconButton(
                            onPressed: widget.navigateToSearch,
                            icon: const Icon(CupertinoIcons.search)),
                      ],
                    )
                  : Container(),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(CupertinoIcons.gear),
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
