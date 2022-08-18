import 'package:tumble/core/helpers/school_enum.dart';

class School {
  final SchoolEnum schoolId;
  final String schoolUrl;
  final String schoolName;
  final String schoolLogo;
  final bool loginRequired;

  School({
    required this.schoolId,
    required this.schoolUrl,
    required this.schoolName,
    required this.schoolLogo,
    required this.loginRequired,
  });
}
