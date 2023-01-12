import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/theme/cubit/theme_cubit.dart';
import 'package:tumble/core/ui/cubit/bottom_nav_cubit.dart';

class TumbleAppBar extends StatefulWidget {
  final VoidCallback? toggleBookmark;
  const TumbleAppBar({
    this.toggleBookmark,
    Key? key,
  }) : super(key: key);

  @override
  State<TumbleAppBar> createState() => _TumbleAppBarState();
}

class _TumbleAppBarState extends State<TumbleAppBar> {
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
              return MediaQuery.of(context).platformBrightness ==
                      Brightness.light
                  ? Brightness.dark
                  : Brightness.light;
          }
        }(),
        statusBarColor: Colors.transparent,
      ),
      actions: <Widget>[
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Spacer(),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 5, right: 5),
                child: IconButton(
                  iconSize: 30,
                  icon: Icon(CupertinoIcons.line_horizontal_3_decrease,
                      color: Theme.of(context).colorScheme.onBackground),
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
