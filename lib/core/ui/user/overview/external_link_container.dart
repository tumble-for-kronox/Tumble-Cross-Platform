import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/ui/app_switch/data/schools.dart';
import 'package:tumble/core/ui/cubit/auth_cubit.dart';
import 'package:tumble/core/ui/user/misc/user_account_info_external_link.dart';

class ExternalLinkContainer extends StatelessWidget {
  const ExternalLinkContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        UserAccountExternalLink(
          title: "Canvas",
          color: const Color(0xFFe23e29),
          icon: CupertinoIcons.square_arrow_left,
          link:
              "https://${Schools.schools.firstWhere((school) => school.schoolName == context.read<AuthCubit>().defaultSchool).schoolId.name}.instructure.com",
        ),
        const SizedBox(
          width: 20,
        ),
        const UserAccountExternalLink(
          title: "Ladok",
          color: Color(0xFF3c9a00),
          icon: CupertinoIcons.square_arrow_left,
          link: "https://www.student.ladok.se/student/app/studentwebb/",
        ),
        const SizedBox(
          width: 20,
        ),
        UserAccountExternalLink(
          title: "Kronox",
          color: const Color(0xFF0089da),
          icon: CupertinoIcons.square_arrow_left,
          link:
              "https://${Schools.schools.firstWhere((school) => school.schoolName == context.read<AuthCubit>().defaultSchool).schoolUrl}",
        ),
      ],
    );
  }
}
