import 'package:tumble/core/ui/app_switch/data/school_enum.dart';
import 'package:tumble/core/models/ui_models/school_model.dart';

/// Stores all respective schools by enum
class Schools {
  static final schools = [
    School(
      schoolId: SchoolEnum.hkr,
      schoolUrl: "schema.hkr.se",
      schoolName: 'Kristianstad University',
      schoolLogo: 'assets/school_logos/hkr_logo.png',
      loginRequired: false,
    ),
    School(
      schoolId: SchoolEnum.mau,
      schoolUrl: "schema.mau.se",
      schoolName: 'Malmö University',
      schoolLogo: 'assets/school_logos/mau_logo.png',
      loginRequired: false,
    ),
    School(
      schoolId: SchoolEnum.oru,
      schoolUrl: "schema.oru.se",
      schoolName: 'Örebro University',
      schoolLogo: 'assets/school_logos/oru_logo.png',
      loginRequired: false,
    ),
    School(
      schoolId: SchoolEnum.ltu,
      schoolUrl: "schema.ltu.se",
      schoolName: 'Luleå University of Technology',
      schoolLogo: 'assets/school_logos/ltu_logo.png',
      loginRequired: false,
    ),
    School(
      schoolId: SchoolEnum.hig,
      schoolUrl: "schema.hig.se",
      schoolName: 'Högskolan i Gävle',
      schoolLogo: 'assets/school_logos/hig_logo.png',
      loginRequired: false,
    ),
    School(
      schoolId: SchoolEnum.sh,
      schoolUrl: "kronox.sh.se",
      schoolName: 'Södertörns Högskola',
      schoolLogo: 'assets/school_logos/sh_logo.png',
      loginRequired: true,
    ),
    School(
      schoolId: SchoolEnum.hv,
      schoolUrl: "schema.hv.se",
      schoolName: 'Högskolan Väst',
      schoolLogo: 'assets/school_logos/hv_logo.png',
      loginRequired: false,
    ),
    School(
      schoolId: SchoolEnum.hb,
      schoolUrl: "schema.hb.se",
      schoolName: 'Högskolan i Borås',
      schoolLogo: 'assets/school_logos/hb_logo.png',
      loginRequired: false,
    ),
    School(
      schoolId: SchoolEnum.mdh,
      schoolUrl: "schema.mdh.se",
      schoolName: 'Mälardalen Högskola',
      schoolLogo: 'assets/school_logos/mdh_logo.png',
      loginRequired: true,
    ),
  ];
}
