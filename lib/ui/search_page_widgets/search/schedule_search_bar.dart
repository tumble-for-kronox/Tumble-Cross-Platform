import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumble/ui/search_page_widgets/cubit/search_page_cubit.dart';

class ScheduleSearchBar extends StatefulWidget {
  const ScheduleSearchBar({Key? key}) : super(key: key);

  @override
  State<ScheduleSearchBar> createState() => _ScheduleSearchBarState();
}

class _ScheduleSearchBarState extends State<ScheduleSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(5),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                  color: Colors.black26, blurRadius: 3, offset: Offset(0, 2))
            ],
          ),
          child: TextField(
              controller: context.read<SearchPageCubit>().textEditingController,
              textInputAction: TextInputAction.search,
              onSubmitted: null,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search schedules",
                hintMaxLines: 1,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                suffixIcon: AnimatedOpacity(
                    opacity: 0,
                    duration: const Duration(milliseconds: 150),
                    child: Material(
                        color: Colors.transparent,
                        child: IconButton(
                          color: Theme.of(context).colorScheme.onSurface,
                          onPressed: () {
                            log("Here");
                            context.read<SearchPageCubit>().search(context
                                .read<SearchPageCubit>()
                                .textEditingController
                                .text);
                          },
                          icon: const Icon(Icons.close),
                          iconSize: 20,
                          splashRadius: 12,
                        ))),
              )),
        )),
        Container(
          height: 50,
          width: 50,
          margin: const EdgeInsets.only(left: 20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(5),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                  color: Colors.black26, blurRadius: 3, offset: Offset(0, 2))
            ],
          ),
          child: MaterialButton(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))),
            onPressed: () async {
              log("Here");
              await context.read<SearchPageCubit>().search(
                  context.read<SearchPageCubit>().textEditingController.text);
            },
            disabledColor: Colors.orange.shade200,
            visualDensity: VisualDensity.compact,
            splashColor: Colors.white.withOpacity(0.4),
            child: Icon(
              Icons.search,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
