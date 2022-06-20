import 'package:tumble/helpers/school_enum.dart';
import 'package:tumble/models/ui_models/school_model.dart';

/// Stores all respective schools by enum
class Schools {
  static final schools = [
    School(
      schoolId: SchoolEnum.hkr,
      schoolName: 'Kristianstad University',
      schoolLogo: 'assets/school_logos/hkr_logo.png',
    ),
    School(
      schoolId: SchoolEnum.mau,
      schoolName: 'Malmö University',
      schoolLogo: 'assets/school_logos/mau_logo.png',
    ),
    School(
      schoolId: SchoolEnum.oru,
      schoolName: 'Örebro University',
      schoolLogo: 'assets/school_logos/oru_logo.png',
    ),
    // School(
    //   schoolId: SchoolEnum.ltu,
    //   schoolName: 'Luleå University of Technology',
    //   schoolLogo: 'assets/school_logos/ltu_logo.png',
    // ),~
    School(
      schoolId: SchoolEnum.hig,
      schoolName: 'Högskolan i Gävle',
      schoolLogo: 'assets/school_logos/hig_logo.png',
    ),
    // School(
    //   schoolId: SchoolEnum.sh,
    //   schoolName: 'Södertörns Högskola',
    //   schoolLogo: 'assets/school_logos/sh_logo.png',
    // ),
    School(
      schoolId: SchoolEnum.hv,
      schoolName: 'Högskolan Väst',
      schoolLogo: 'assets/school_logos/hv_logo.png',
    ),
    School(
      schoolId: SchoolEnum.hb,
      schoolName: 'Högskolan i Borås',
      schoolLogo: 'assets/school_logos/hb_logo.png',
    ),
    School(
      schoolId: SchoolEnum.mdh,
      schoolName: 'Mälardalen Högskola',
      schoolLogo: 'assets/school_logos/mdh_logo.png',
    ),
  ];
}
