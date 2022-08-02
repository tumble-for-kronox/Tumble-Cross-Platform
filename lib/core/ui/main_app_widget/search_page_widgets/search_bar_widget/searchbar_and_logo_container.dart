import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/ui/main_app_widget/search_page_widgets/cubit/search_page_cubit.dart';
import 'package:tumble/core/ui/main_app_widget/search_page_widgets/search/schedule_search_bar.dart';
import 'package:tumble/core/ui/main_app_widget/search_page_widgets/search/search_page_slideable_logo.dart';

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
                  top: MediaQuery.of(context).viewPadding.top + 20),
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
