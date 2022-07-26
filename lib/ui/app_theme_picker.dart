import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef SetTheme = void Function(String themeType);

class AppThemePicker extends StatelessWidget {
  final SetTheme setTheme;
  const AppThemePicker({Key? key, required this.setTheme}) : super(key: key);

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
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 10,
                    ),
                    ListTile(
                        leading: Icon(
                          CupertinoIcons.moon,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        title: Text(
                          'Dark theme',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        onTap: () => setTheme('dark')),
                    ListTile(
                        leading: Icon(
                          CupertinoIcons.sun_max,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        title: Text(
                          'Light theme',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        onTap: () => setTheme('dark')),
                    ListTile(
                        leading: Icon(
                          CupertinoIcons.device_phone_portrait,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        title: Text(
                          'Follow system theme',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        onTap: () => setTheme('dark')),
                    const SizedBox(height: 10)
                  ],
                ))),
      ),
    );
  }
}
