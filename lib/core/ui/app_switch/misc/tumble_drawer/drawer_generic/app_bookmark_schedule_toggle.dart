import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/ui/cubit/drawer_state.dart';
import 'package:tumble/core/ui/data/string_constants.dart';

class ApplicationBookmarkPicker extends StatefulWidget {
  const ApplicationBookmarkPicker({
    Key? key,
  }) : super(key: key);

  @override
  State<ApplicationBookmarkPicker> createState() => _ApplicationBookmarkPickerState();
}

class _ApplicationBookmarkPickerState extends State<ApplicationBookmarkPicker> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 240,
            margin: const EdgeInsets.only(bottom: 20, left: 12, right: 12),
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
                    children:
                        (context.read<DrawerCubit>().state.bookmarks!.map((bookmark) => bookmark.scheduleId).toList())
                            .map((id) {
                  return BlocBuilder<DrawerCubit, DrawerState>(
                    builder: (context, state) {
                      if (state.mapOfIdToggles?[id] != null) {
                        return SwitchListTile(
                          activeColor: Theme.of(context).colorScheme.primary,
                          secondary: IconButton(
                              visualDensity: VisualDensity.compact,
                              padding: EdgeInsets.zero,
                              enableFeedback: true,
                              icon: Icon(
                                CupertinoIcons.delete,
                                size: 20,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              onPressed: () async {
                                context.read<DrawerCubit>().removeBookmark(id);
                              }),
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                          title: Text(
                            id,
                            style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                          ),
                          onChanged: (bool value) {
                            BlocProvider.of<DrawerCubit>(context).toggleSchedule(id, value);
                            if (state.bookmarks!.isEmpty) {
                              Navigator.of(context).pop();
                            }
                          },
                          value: state.mapOfIdToggles![id]!,
                        );
                      } else if (state.bookmarks!.isEmpty) {
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
                                    child: Center(
                                        child: Text(
                                      S.settingsPage.bookmarksEmpty(),
                                      style: TextStyle(fontSize: 20, color: Theme.of(context).colorScheme.onSurface),
                                    )))),
                          ),
                        );
                      }
                      return Container();
                    },
                  );
                }).toList()),
              ),
            )),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 25, left: 12, right: 12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Card(
              elevation: 0,
              color: Theme.of(context).colorScheme.surface,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              child: ListTile(
                onTap: () => Navigator.pop(context),
                title: Text(
                  S.general.cancel(),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
