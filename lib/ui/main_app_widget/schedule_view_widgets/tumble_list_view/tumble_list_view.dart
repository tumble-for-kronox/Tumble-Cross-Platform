import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/models/api_models/schedule_model.dart';
import 'package:tumble/ui/main_app_widget/cubit/main_app_cubit.dart';
import 'package:tumble/ui/main_app_widget/schedule_view_widgets/no_schedule.dart';
import 'tumble_list_view_day_container.dart';

class TumbleListView extends StatelessWidget {
  const TumbleListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainAppCubit, MainAppState>(
      builder: (context, state) {
        if (state is MainAppScheduleSelected) {
          SingleChildScrollView(
            child: Column(
                children: state.listOfDays
                    .where((day) => day.events.isNotEmpty)
                    .map((day) => TumbleListViewDayContainer(
                          day: day,
                        ))
                    .toList()),
          );
        }
        return const NoScheduleAvailable(errorType: 'No schedule selected');
      },
    );
  }
}
