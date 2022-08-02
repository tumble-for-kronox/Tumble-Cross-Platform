import 'package:flutter/material.dart';
import 'package:tumble/core/ui/main_app_widget/misc/tumble_drawer/drawer_generic/data/default_views_map.dart';

typedef SetDefaultView = void Function(int viewType);

class AppDefaultViewPicker extends StatelessWidget {
  final SetDefaultView setDefaultView;
  const AppDefaultViewPicker({Key? key, required this.setDefaultView})
      : super(key: key);

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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Column(
              children: (IconAndTitleSet.views)
                  .keys
                  .map((keyType) => ListTile(
                      leading: IconAndTitleSet.views[keyType]!.values.first,
                      title: Text(
                        keyType,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                      onTap: () => setDefaultView(
                          IconAndTitleSet.views[keyType]!.keys.first)))
                  .toList()),
        )),
      ),
    );
  }
}
