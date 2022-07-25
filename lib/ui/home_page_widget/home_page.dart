import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tumble/theme/colors.dart';
import 'package:tumble/ui/home_page_widget/bottom_nav_widget/cubit/bottom_nav_cubit.dart';
import 'package:tumble/ui/home_page_widget/cubit/home_page_cubit.dart';
import 'package:tumble/ui/home_page_widget/bottom_nav_widget/custom_bottom_bar.dart';
import 'package:tumble/ui/home_page_widget/schedule_view_widgets/misc/tumble_app_drawer.dart';
import 'package:tumble/ui/home_page_widget/schedule_view_widgets/no_schedule.dart';
import 'package:tumble/ui/home_page_widget/schedule_view_widgets/tumble_list_view/tumble_list_view.dart';
import 'package:tumble/ui/home_page_widget/schedule_view_widgets/tumble_week_view/tumble_week_view.dart';
import 'package:tumble/ui/home_page_widget/schedule_view_widgets/misc/tumble_app_bar.dart';

class HomePage extends StatefulWidget {
  final String? currentScheduleId;

  const HomePage({
    Key? key,
    this.currentScheduleId,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer: const TumbleAppDrawer(
          limitOptions: false,
        ),
        appBar: TumbleAppBar(
          navigateToSearch: () =>
              context.read<HomePageCubit>().navigateToSearch(context),
          toggleFavorite: () => context
              .read<HomePageCubit>()
              .assignFavorite(widget.currentScheduleId!),
        ),
        body: FutureBuilder(
            future:
                context.read<HomePageCubit>().init(widget.currentScheduleId!),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return BlocBuilder<HomePageCubit, HomePageState>(
                builder: (context, state) {
                  if (state is HomePageListView) {
                    return TumbleListView(
                        scheduleId: state.scheduleId,
                        listOfDays: state.listOfDays);
                  }
                  if (state is HomePageWeekView) {
                    return TumbleWeekView(
                        scheduleId: state.scheduleId,
                        listOfWeeks: state.listOfWeeks);
                  }
                  if (state is HomePageError) {
                    return const NoScheduleAvailable();
                  }
                  return const SpinKitThreeBounce(
                      color: CustomColors.orangePrimary);
                },
              );
            }),
        bottomNavigationBar: CustomBottomBar(onTap: (index) {
          context.read<HomePageCubit>().setPage(index);
          context.read<BottomNavCubit>().updateIndex(index);
        }));
  }
}
