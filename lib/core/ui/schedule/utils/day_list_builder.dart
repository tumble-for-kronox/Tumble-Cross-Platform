import 'package:tumble/core/api/database/repository/database_repository.dart';
import 'package:tumble/core/models/backend_models/schedule_model.dart';
import 'package:tumble/core/theme/color_picker.dart';

class DayListBuilder {
  static Future<List<Day>> buildListOfDays(ScheduleModel newScheduleModel, DatabaseRepository databaseService) async {
    /// Create map of course id's and colors associated with course,
    /// due to the course being previously saved in the database we need
    /// to retrieve the colors and assign them to the incoming one
    Map<String, int> courseColors = await databaseService.getCourseColors();
    List<Course> scheduleCourses =
        newScheduleModel.days.expand((day) => day.events.map((event) => event.course)).toSet().toList();

    for (var course in scheduleCourses) {
      if (!courseColors.containsKey(course.id)) {
        courseColors = await databaseService.updateCourseColor(course.id, ColorPicker().getRandomHexColor());
      }
    }

    return Future.wait(newScheduleModel.days
        .map((day) async => Day(
            name: day.name,
            date: day.date,
            isoString: day.isoString,
            weekNumber: day.weekNumber,
            events: day.events
                .map((event) => Event(
                    id: event.id,
                    title: event.title,
                    course: getCourseWithColor(event, courseColors),
                    from: event.from,
                    to: event.to,
                    locations: event.locations,
                    teachers: event.teachers,
                    isSpecial: event.isSpecial,
                    lastModified: event.lastModified))
                .toList()))
        .toList());
  }

  static Course getCourseWithColor(Event event, Map<String, int> courseColors) {
    /// Checks if incoming schedule course colors
    /// are null, if they are then assign new random
    /// colors.
    return Course(
        id: event.course.id,
        swedishName: event.course.swedishName,
        englishName: event.course.englishName,
        courseColor: courseColors[event.course.id]);
  }
}
