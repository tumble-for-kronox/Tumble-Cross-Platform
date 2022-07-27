import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/ui/main_app_widget/cubit/main_app_cubit.dart';

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
      backgroundColor: Theme.of(context).colorScheme.background,
      actions: <Widget>[
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  widget.visibleBookmark!
                      ? BlocBuilder<MainAppCubit, MainAppState>(
                          builder: (context, state) {
                            if (state is MainAppScheduleSelected) {
                              return IconButton(
                                  onPressed: widget.toggleFavorite,
                                  icon: Icon(
                                      state.toggledFavorite
                                          ? CupertinoIcons.bookmark_fill
                                          : CupertinoIcons.bookmark,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground));
                            }
                            return Container();
                          },
                        )
                      : Container(),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(CupertinoIcons.gear,
                        color: Theme.of(context).colorScheme.onBackground),
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
