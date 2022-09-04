import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/theme/cubit/theme_cubit.dart';
import 'package:tumble/core/ui/bottom_nav_bar/cubit/bottom_nav_cubit.dart';
import 'package:tumble/core/ui/search/cubit/search_page_cubit.dart';

class TumbleAppBar extends StatefulWidget {
  final int? pageIndex;
  final AsyncCallback? toggleBookmark;
  const TumbleAppBar({
    this.pageIndex,
    this.toggleBookmark,
    Key? key,
  }) : super(key: key);

  @override
  State<TumbleAppBar> createState() => _TumbleAppBarState();
}

class _TumbleAppBarState extends State<TumbleAppBar> {
  final navBarIndicies = [1, 2, 3, 4];
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.background,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: () {
          switch (BlocProvider.of<ThemeCubit>(context).state.themeMode) {
            case ThemeMode.dark:
              return Brightness.light;
            case ThemeMode.light:
              return Brightness.dark;
            case ThemeMode.system:
              return MediaQuery.of(context).platformBrightness;
          }
        }(),
        statusBarIconBrightness: () {
          switch (BlocProvider.of<ThemeCubit>(context).state.themeMode) {
            case ThemeMode.dark:
              return Brightness.light;
            case ThemeMode.light:
              return Brightness.dark;
            case ThemeMode.system:
              return MediaQuery.of(context).platformBrightness == Brightness.light ? Brightness.dark : Brightness.light;
          }
        }(),
        statusBarColor: Colors.transparent,
      ),
      actions: <Widget>[
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BlocBuilder<SearchPageCubit, SearchPageState>(builder: (context, state) {
                switch (state.previewFetchStatus) {
                  case PreviewFetchStatus.EMPTY_SCHEDULE:
                  case PreviewFetchStatus.FETCH_ERROR:
                  case PreviewFetchStatus.LOADING:
                  case PreviewFetchStatus.INITIAL:
                    return const Padding(
                      padding: EdgeInsets.only(top: 10, left: 10),
                      child: IconButton(
                          iconSize: 30,
                          onPressed: null,
                          icon: Icon(CupertinoIcons.bookmark, color: Colors.transparent)),
                    );

                  case PreviewFetchStatus.CACHED_SCHEDULE:
                  case PreviewFetchStatus.FETCHED_SCHEDULE:
                    if (!navBarIndicies.contains(widget.pageIndex)) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 5, right: 5),
                        child: IconButton(
                            iconSize: 30,
                            onPressed: widget.toggleBookmark,
                            icon: Icon(
                                BlocProvider.of<SearchPageCubit>(context).state.previewToggledFavorite!
                                    ? CupertinoIcons.bookmark_fill
                                    : CupertinoIcons.bookmark,
                                color: Theme.of(context).colorScheme.onBackground)),
                      );
                    } else {
                      return const Padding(
                        padding: EdgeInsets.only(top: 10, left: 10),
                        child: IconButton(
                            iconSize: 30,
                            onPressed: null,
                            icon: Icon(CupertinoIcons.bookmark, color: Colors.transparent)),
                      );
                    }
                }
              }),
              Container(
                padding: const EdgeInsets.only(top: 15),
                child: BlocBuilder<MainAppNavigationCubit, MainAppNavigationState>(
                    builder: ((context, state) => Text(
                          state.navbarItem.toStringTitle(),
                          style: TextStyle(
                              fontSize: 15, letterSpacing: 2, color: Theme.of(context).colorScheme.onBackground),
                        ))),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5, right: 5),
                    child: IconButton(
                      iconSize: 30,
                      icon: Icon(CupertinoIcons.gear, color: Theme.of(context).colorScheme.onBackground),
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
