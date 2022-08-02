import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/ui/main_app_widget/cubit/main_app_cubit.dart';
import 'package:tumble/core/ui/main_app_widget/main_app_bottom_nav_bar/cubit/bottom_nav_cubit.dart';

class TumbleAppBar extends StatefulWidget implements PreferredSizeWidget {
  final AsyncCallback? toggleFavorite;
  final bool? visibleBookmark;
  const TumbleAppBar({Key? key, this.toggleFavorite, this.visibleBookmark})
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
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.background,
      actions: <Widget>[
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (widget.visibleBookmark!)
                    BlocBuilder<MainAppCubit, MainAppState>(
                      builder: (context, state) {
                        switch (state.status) {
                          case MainAppStatus.SCHEDULE_SELECTED:
                            return Padding(
                              padding: const EdgeInsets.only(left: 5, top: 5),
                              child: IconButton(
                                  iconSize: 30,
                                  onPressed: widget.toggleFavorite,
                                  icon: Icon(
                                      state.toggledFavorite
                                          ? CupertinoIcons.bookmark_fill
                                          : CupertinoIcons.bookmark,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground)),
                            );
                          default:
                            return Padding(
                              padding: const EdgeInsets.only(top: 5, right: 5),
                              child: IconButton(
                                  iconSize: 30,
                                  onPressed: widget.toggleFavorite,
                                  icon: const Icon(CupertinoIcons.bookmark,
                                      color: Colors.transparent)),
                            );
                        }
                      },
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.only(top: 5, right: 5),
                      child: IconButton(
                          iconSize: 30,
                          onPressed: widget.toggleFavorite,
                          icon: const Icon(CupertinoIcons.bookmark,
                              color: Colors.transparent)),
                    ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(top: 15),
                child:
                    BlocBuilder<MainAppNavigationCubit, MainAppNavigationState>(
                        builder: ((context, state) => Text(
                              state.navbarItem.name.humanize().toUpperCase(),
                              style: TextStyle(
                                  fontSize: 15,
                                  letterSpacing: 2,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                            ))),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5, right: 5),
                    child: IconButton(
                      iconSize: 30,
                      icon: Icon(CupertinoIcons.gear,
                          color: Theme.of(context).colorScheme.onBackground),
                      onPressed: () => Scaffold.of(context).openEndDrawer(),
                    ),
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
