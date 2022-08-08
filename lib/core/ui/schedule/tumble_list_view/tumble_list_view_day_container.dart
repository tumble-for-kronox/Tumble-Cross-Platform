import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tumble/core/models/api_models/schedule_model.dart';
import 'package:tumble/core/models/ui_models/course_model.dart';
import 'package:tumble/core/theme/data/colors.dart';
import 'package:tumble/core/ui/main_app/cubit/main_app_cubit.dart';
import 'package:tumble/core/ui/main_app/main_app.dart';
import 'package:tumble/core/ui/schedule/event_modal.dart';
import 'package:tumble/core/ui/schedule/tumble_list_view/tumble_list_view_schedule_card.dart';

class TumbleListViewDayContainer extends StatelessWidget {
  final Day day;
  final MainAppCubit mainAppCubit;
  const TumbleListViewDayContainer(
      {Key? key, required this.day, required this.mainAppCubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 20),
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              Text("${day.name} ${day.date}",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 17,
                      fontWeight: FontWeight.w400)),
              Expanded(
                  child: Divider(
                color: Theme.of(context).colorScheme.onBackground,
                indent: 6,
                thickness: 1,
              ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 2),
            child: Column(
              children: day.events
                  .map((event) => ScheduleCard(
                      event: event,
                      color: event.isSpecial
                          ? Colors.redAccent
                          : Color(mainAppCubit
                              .state.scheduleModelAndCourses!.courses
                              .firstWhere((CourseUiModel? courseUiModel) =>
                                  courseUiModel!.courseId == event.course.id)!
                              .color),
                      onTap: () {
                        showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) => TumbleEventModal(
                                event: event,
                                color: event.isSpecial
                                    ? Colors.redAccent
                                    : Color(mainAppCubit
                                        .state.scheduleModelAndCourses!.courses
                                        .firstWhere(
                                            (CourseUiModel? courseUiModel) =>
                                                courseUiModel!.courseId ==
                                                event.course.id)!
                                        .color)));
                      }))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
