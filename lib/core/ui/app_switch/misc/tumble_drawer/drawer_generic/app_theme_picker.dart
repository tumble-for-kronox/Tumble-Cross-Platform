import 'package:flutter/material.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/ui/data/string_constants.dart';
import 'package:tumble/core/ui/app_switch/misc/tumble_drag_pill.dart';
import 'package:tumble/core/ui/app_switch/misc/tumble_drawer/drawer_generic/data/default_views_map.dart';
import 'package:tumble/core/ui/scaffold_message.dart';
import 'package:tumble/core/ui/schedule/cancel_button.dart';

typedef SetTheme = void Function(String themeType);

class AppThemePicker extends StatelessWidget {
  final SetTheme setTheme;

  const AppThemePicker({Key? key, required this.setTheme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: 180,
          margin: const EdgeInsets.only(bottom: 25, left: 12, right: 12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(children: [
            SizedBox.expand(
                child: Card(
                    elevation: 0,
                    color: Theme.of(context).colorScheme.surface,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Column(
                        children: (IconAndTitleSet.themes.keys)
                            .map((key) => ListTile(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                leading: IconAndTitleSet.themes[key],
                                title: Text(
                                  key,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground),
                                ),
                                onTap: () {
                                  showScaffoldMessage(
                                      context,
                                      S.scaffoldMessages.changeTheme(
                                          key.split(' ').first.toLowerCase()));
                                  setTheme(key.split(' ').first.toLowerCase());
                                }))
                            .toList()))),
            TumbleDragPill(
                barColor:
                    Theme.of(context).colorScheme.background.contrastColor())
          ]),
        ),
        const CancelButton()
      ],
    );
  }
}
