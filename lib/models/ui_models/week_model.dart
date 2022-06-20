import 'package:tumble/models/api_models/schedule_model.dart';

class Week {
  final int weekNumber;
  final List<Event> events;

  Week({required this.weekNumber, required this.events});

  factory Week.fromEventList(int weekNumber, List<Event> events) {
    return Week(weekNumber: weekNumber, events: events);
  }
}
