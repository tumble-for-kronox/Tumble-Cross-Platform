import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/models/api_models/bookmarked_schedule_model.dart';
import 'package:tumble/core/ui/main_app/cubit/main_app_cubit.dart';
import 'package:tumble/core/ui/main_app/misc/tumble_drawer/cubit/drawer_state.dart';

class AppFavoriteScheduleToggle extends StatefulWidget {
  const AppFavoriteScheduleToggle({
    Key? key,
  }) : super(key: key);

  @override
  State<AppFavoriteScheduleToggle> createState() =>
      _AppFavoriteScheduleToggleState();
}

class _AppFavoriteScheduleToggleState extends State<AppFavoriteScheduleToggle> {
  Map<String, bool>? mapOfIdToggles;

  @override
  void initState() {
    if (context.read<DrawerCubit>().state.mapOfIdToggles != null) {
      mapOfIdToggles = context.read<DrawerCubit>().state.mapOfIdToggles!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (mapOfIdToggles != null) {
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
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: SingleChildScrollView(
              child: Column(
                  children: (context
                          .read<DrawerCubit>()
                          .state
                          .bookmarks!
                          .map((bookmark) => bookmark.scheduleId)
                          .toList())
                      .map((id) {
                return BlocBuilder<DrawerCubit, DrawerState>(
                  builder: (context, state) {
                    return SwitchListTile(
                      activeColor: Theme.of(context).colorScheme.primary,
                      secondary: IconButton(
                          visualDensity: VisualDensity.compact,
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            CupertinoIcons.clear_circled,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          onPressed: () async {
                            BlocProvider.of<MainAppCubit>(context).setLoading();
                            context.read<DrawerCubit>().removeBookmark(id).then(
                                (_) =>
                                    context.read<MainAppCubit>().tryCached());
                          }),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      title: Text(
                        id,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                      onChanged: (bool value) {
                        BlocProvider.of<DrawerCubit>(context)
                            .toggleSchedule(id, value);
                        BlocProvider.of<MainAppCubit>(context).setLoading();
                        BlocProvider.of<MainAppCubit>(context)
                            .tryCached()
                            .then((value) {
                          if (state.bookmarks!.isEmpty) {
                            Navigator.of(context).pop();
                          }
                        });
                      },
                      value: mapOfIdToggles![id]!,
                    );
                  },
                );
              }).toList()),
            ),
          )),
        ),
      );
    }
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
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: const Text('No bookmarks yet'))),
      ),
    );
  }
}
