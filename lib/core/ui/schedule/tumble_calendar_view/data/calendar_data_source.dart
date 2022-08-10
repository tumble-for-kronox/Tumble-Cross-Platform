import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:tumble/core/models/api_models/schedule_model.dart';
import 'package:tumble/core/ui/main_app/cubit/main_app_cubit.dart';

Future<AppointmentDataSource> getCalendarDataSource(
    List<Day> days, MainAppCubit cubit) async {
  List<Appointment> appointments = <Appointment>[];
  for (Day day in days) {
    for (Event event in day.events) {
      appointments.add(Appointment(
        startTime: event.timeStart,
        endTime: event.timeEnd,
        subject: event.title,
        color: cubit.getColorForCourse(event).withOpacity(0.35),
      ));
    }
  }
  return AppointmentDataSource(appointments);
}

class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
