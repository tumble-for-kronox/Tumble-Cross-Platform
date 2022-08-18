import 'package:flutter/material.dart';
import 'package:tumble/core/ui/data/scaffold_message_types.dart';
import 'package:tumble/core/ui/main_app/misc/tumble_drawer/drawer_generic/data/default_views_map.dart';
import 'package:tumble/core/ui/scaffold_message.dart';

typedef SetTheme = void Function(String themeType);

class AppThemePicker extends StatelessWidget {
  final SetTheme setTheme;

  const AppThemePicker({Key? key, required this.setTheme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 180,
        margin: const EdgeInsets.only(bottom: 25, left: 12, right: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
        ),
        child: SizedBox.expand(
            child: Card(
                elevation: 0,
                color: Theme.of(context).colorScheme.surface,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                    children: (IconAndTitleSet.themes.keys)
                        .map((key) => ListTile(
                            leading: IconAndTitleSet.themes[key],
                            title: Text(
                              key,
                              style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                            ),
                            onTap: () {
                              showScaffoldMessage(
                                  context, ScaffoldMessageType.changeTheme(key.split(' ').first.toLowerCase()));
                              setTheme(key.split(' ').first.toLowerCase());
                            }))
                        .toList()))),
      ),
    );
  }
}
