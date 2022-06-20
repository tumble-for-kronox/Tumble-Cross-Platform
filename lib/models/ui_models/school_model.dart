import 'package:tumble/helpers/school_enum.dart';

class School {
  final SchoolEnum schoolId;
  final String schoolName;
  final String schoolLogo;

  School({
    required this.schoolId,
    required this.schoolName,
    required this.schoolLogo,
  });
}
