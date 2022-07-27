import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef SetTheme = void Function(String themeType);

class AppThemePicker extends StatelessWidget {
  final SetTheme setTheme;
  final Map<String, Icon> iconAndTitleSet = {
    "Dark theme": const Icon(CupertinoIcons.moon),
    "Light theme": const Icon(CupertinoIcons.sun_max),
    "System theme": const Icon(CupertinoIcons.device_phone_portrait)
  };
  AppThemePicker({Key? key, required this.setTheme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 200,
        margin: const EdgeInsets.only(bottom: 30, left: 12, right: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox.expand(
            child: Card(
                elevation: 0,
                color: Theme.of(context).colorScheme.surface,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                    children: (iconAndTitleSet.keys)
                        .map((key) => ListTile(
                            leading: iconAndTitleSet[key],
                            title: Text(
                              key,
                              style: TextStyle(color: Theme.of(context).colorScheme.primary),
                            ),
                            onTap: () {
                              setTheme(key.split(' ').first.toLowerCase());
                            }))
                        .toList()))),
      ),
    );
  }
}
