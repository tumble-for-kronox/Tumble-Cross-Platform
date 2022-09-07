import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/ui/bottom_nav_bar/cubit/bottom_nav_cubit.dart';
import 'package:tumble/core/ui/bottom_nav_bar/data/nav_bar_items.dart';
import 'package:tumble/core/ui/main_app/cubit/main_app_cubit.dart';
import 'package:tumble/core/ui/search/cubit/search_page_cubit.dart';
import 'package:tumble/core/ui/search/search/schedule_search_bar.dart';
import 'package:tumble/core/ui/search/search/search_page_slideable_logo.dart';

class SearchBarAndLogoContainer extends StatefulWidget {
  const SearchBarAndLogoContainer({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchBarAndLogoContainer> createState() =>
      _SearchBarAndLogoContainerState();
}

class _SearchBarAndLogoContainerState extends State<SearchBarAndLogoContainer> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: BlocProvider.of<SearchPageCubit>(context).init(),
      builder: ((context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).viewPadding.top + 5),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    child: BlocBuilder<SearchPageCubit, SearchPageState>(
                        builder: (context, state) {
                      return SlideableLogo(
                        focused: state.focused,
                      );
                    }),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    margin: const EdgeInsets.only(bottom: 10),
                    child: BlocProvider.value(
                      value: BlocProvider.of<SearchPageCubit>(context),
                      child: const ScheduleSearchBar(),
                    ),
                  ),
                  if (context.read<MainAppCubit>().hasBookMarkedSchedules)
                    Expanded(
                      child: BlocBuilder<SearchPageCubit, SearchPageState>(
                        builder: (context, state) {
                          if (state.focused) {
                            return Container();
                          }
                          return Container(
                              padding: const EdgeInsets.only(top: 200),
                              child: MaterialButton(
                                onPressed: () => context
                                    .read<MainAppNavigationCubit>()
                                    .getNavBarItem(NavbarItem.LIST),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'View your schedules',
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground
                                            .withOpacity(.8),
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      CupertinoIcons.arrow_right,
                                      size: 15,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground
                                          .withOpacity(.8),
                                    )
                                  ],
                                ),
                              ));
                        },
                      ),
                    )
                ],
              ),
            );
          default:
            return Container();
        }
      }),
    );
  }
}
