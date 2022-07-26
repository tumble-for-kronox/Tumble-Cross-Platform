import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/ui/home_page_widget/cubit/home_page_cubit.dart';

class TumbleAppBar extends StatefulWidget implements PreferredSizeWidget {
  final VoidCallback? navigateToSearch;
  final AsyncCallback? toggleFavorite;
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
      backgroundColor: Theme.of(context).colorScheme.background,
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
                        BlocBuilder<HomePageCubit, HomePageState>(
                          builder: (context, state) {
                            if (state is HomePageListView) {
                              return IconButton(
                                  onPressed: widget.toggleFavorite,
                                  icon: Icon(
                                    state.isFavorite
                                        ? CupertinoIcons.bookmark_fill
                                        : CupertinoIcons.bookmark,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                  ));
                            }
                            if (state is HomePageWeekView) {
                              return IconButton(
                                  onPressed: widget.toggleFavorite,
                                  icon: Icon(
                                      state.isFavorite
                                          ? CupertinoIcons.bookmark_fill
                                          : CupertinoIcons.bookmark,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground));
                            }
                            return IconButton(
                                onPressed: null,
                                icon: Icon(CupertinoIcons.bookmark,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground));
                          },
                        ),
                        IconButton(
                            onPressed: () => context
                                .read<HomePageCubit>()
                                .navigateToSearch(context),
                            icon: Icon(CupertinoIcons.search,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onBackground)),
                      ],
                    )
                  : Container(),
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
