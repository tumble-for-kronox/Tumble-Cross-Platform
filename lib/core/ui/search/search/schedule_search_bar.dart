import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/ui/data/string_constants.dart';
import 'package:tumble/core/ui/search/cubit/search_page_cubit.dart';

class ScheduleSearchBar extends StatefulWidget {
  const ScheduleSearchBar({Key? key}) : super(key: key);

  @override
  State<ScheduleSearchBar> createState() => _ScheduleSearchBarState();
}

class _ScheduleSearchBarState extends State<ScheduleSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
              child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            height: 47,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                    color: Colors.black26, blurRadius: 3, offset: Offset(0, 2))
              ],
            ),
            child: BlocBuilder<SearchPageCubit, SearchPageState>(
              builder: (context, state) {
                return TextField(
                    onSubmitted: (value) async {
                      if (value.trim().isNotEmpty) {
                        BlocProvider.of<SearchPageCubit>(context).setLoading();
                        await BlocProvider.of<SearchPageCubit>(context)
                            .search();
                      }
                    },
                    autocorrect: false,
                    focusNode:
                        BlocProvider.of<SearchPageCubit>(context).focusNode,
                    controller: context
                        .read<SearchPageCubit>()
                        .textEditingControllerSearch,
                    textInputAction: TextInputAction.search,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondary
                              .withOpacity(.5)),
                      prefixIcon: IconButton(
                        icon: const Icon(
                          CupertinoIcons.search,
                        ),
                        onPressed: () async {
                          if (BlocProvider.of<SearchPageCubit>(context)
                              .textEditingControllerSearch
                              .text
                              .trim()
                              .isNotEmpty) {
                            BlocProvider.of<SearchPageCubit>(context)
                                .setLoading();
                            await BlocProvider.of<SearchPageCubit>(context)
                                .search();
                          }
                        },
                      ),
                      suffixIcon: () {
                        if (state.clearButtonVisible) {
                          return IconButton(
                            onPressed: () =>
                                BlocProvider.of<SearchPageCubit>(context)
                                    .resetCubit(),
                            icon: const Icon(CupertinoIcons.clear),
                          );
                        }
                      }(),
                      border: InputBorder.none,
                      hintText: state.focused
                          ? S.searchPage.searchBarFocusedPlaceholder()
                          : S.searchPage.searchBarUnfocusedPlaceholder(),
                      hintMaxLines: 1,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                    ));
              },
            ),
          )),
        ],
      ),
    );
  }
}
