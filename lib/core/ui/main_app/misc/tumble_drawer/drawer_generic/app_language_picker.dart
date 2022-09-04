import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tumble/core/ui/data/string_constants.dart';

typedef SetNotificationTime = void Function(int time);

class AppLanguagePicker extends StatelessWidget {
  final Map<String, Locale?> parameterMap;
  final Function(Locale?) setLocale;
  final Locale? currentLocale;

  const AppLanguagePicker({Key? key, required this.parameterMap, required this.setLocale, required this.currentLocale})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 240,
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
          child: SingleChildScrollView(
            child: Column(
                children: (parameterMap.keys)
                    .map((key) => ListTile(
                        leading: parameterMap[key] == currentLocale ? const Icon(CupertinoIcons.check_mark) : null,
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                        title: Text(
                          key,
                          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                        ),
                        onTap: () => setLocale(parameterMap[key])))
                    .toList()),
          ),
        )),
      ),
    );
  }
}
