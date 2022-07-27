import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tumble/ui/main_app_widget/cubit/main_app_cubit.dart';
import 'package:tumble/ui/main_app_widget/schedule_view_widgets/no_schedule.dart';
import 'package:tumble/ui/main_app_widget/schedule_view_widgets/tumble_week_view/week_list_view.dart';

import '../../../../theme/data/colors.dart';

class TumbleWeekView extends StatefulWidget {
  const TumbleWeekView({Key? key}) : super(key: key);

  @override
  State<TumbleWeekView> createState() => _TumbleWeekViewState();
}

class _TumbleWeekViewState extends State<TumbleWeekView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainAppCubit, MainAppState>(
      builder: (context, state) {
        if (state is MainAppScheduleSelected) {
          return Stack(children: [
            SizedBox(
                child: PageView.builder(
                    itemCount: state.listOfWeeks.length,
                    itemBuilder: (context, index) {
                      return TumbleWeekPageContainer(
                        scheduleId: state.currentScheduleId,
                        week: state.listOfWeeks[index],
                      );
                    }))
          ]);
        }
        if (state is MainAppLoading) {
          return const SpinKitThreeBounce(color: CustomColors.orangePrimary);
        }
        return const NoScheduleAvailable(errorType: 'No bookmarked schedules');
      },
    );
  }
}
