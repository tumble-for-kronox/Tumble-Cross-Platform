import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/ui/bottom_nav_bar/data/nav_bar_items.dart';
import 'package:tumble/core/ui/cubit/bottom_nav_cubit.dart';
import 'package:tumble/core/ui/cubit/search_page_cubit.dart';
import 'package:tumble/core/ui/data/string_constants.dart';
import 'package:tumble/core/ui/search/schedule_search_bar.dart';
import 'package:tumble/core/ui/search/search_page_slideable_logo.dart';

class SearchBarAndLogoContainer extends StatefulWidget {
  const SearchBarAndLogoContainer({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchBarAndLogoContainer> createState() => _SearchBarAndLogoContainerState();
}

class _SearchBarAndLogoContainerState extends State<SearchBarAndLogoContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top + 5),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            child: BlocBuilder<SearchPageCubit, SearchPageState>(builder: (context, state) {
              return SlideableLogo(
                focused: state.focused,
              );
            }),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            margin: const EdgeInsets.only(bottom: 10),
            child: BlocProvider.value(
              value: BlocProvider.of<SearchPageCubit>(context),
              child: const ScheduleSearchBar(),
            ),
          ),
          BlocBuilder<SearchPageCubit, SearchPageState>(
            builder: (context, state) {
              return state.hasBookmarkedSchedules
                  ? Expanded(
                      child: BlocBuilder<SearchPageCubit, SearchPageState>(
                        builder: (context, state) {
                          if (state.focused) {
                            return Container();
                          }
                          return Container(
                            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height - 680),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 1),
                                  child: MaterialButton(
                                    height: 159,
                                    padding: const EdgeInsets.only(top: 15),
                                    focusElevation: 0,
                                    highlightElevation: 0,
                                    color: Theme.of(context).colorScheme.primary,
                                    onPressed: () => context.read<NavigationCubit>().getNavBarItem(NavbarItem.LIST),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          S.searchPage.toScheduleView(),
                                          style: TextStyle(
                                            color: Theme.of(context).colorScheme.onPrimary.withOpacity(.9),
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          CupertinoIcons.arrow_right,
                                          size: 15,
                                          color: Theme.of(context).colorScheme.onPrimary.withOpacity(.9),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).colorScheme.background,
                                      borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                                    ),
                                    height: 25,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  : Container();
            },
          )
        ],
      ),
    );
  }
}
