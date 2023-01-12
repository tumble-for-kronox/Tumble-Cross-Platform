import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/ui/app_switch/data/schools.dart';
import 'package:tumble/core/ui/cubit/auth_cubit.dart';
import 'package:tumble/core/ui/data/string_constants.dart';

class UserAccountContainer extends StatelessWidget {
  const UserAccountContainer({super.key});

  @override
  Widget build(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width - 40,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                color: Colors.black26, blurRadius: 2, offset: Offset(0, 1))
          ],
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(7.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.authorizedPage.hello(),
                      style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onSecondary),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      maxLines: 2,
                      softWrap: true,
                      BlocProvider.of<AuthCubit>(context)
                          .state
                          .userSession!
                          .name,
                      style: TextStyle(
                          fontSize: 22,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.book,
                          color: Theme.of(context).colorScheme.onSecondary,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          context.read<AuthCubit>().defaultSchool,
                          style: TextStyle(
                              fontSize: 15,
                              color: Theme.of(context).colorScheme.onSecondary),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, right: 10, bottom: 10),
                child: Align(
                  alignment: Alignment.topRight,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(7.5),
                    child: Image.asset(
                      Schools.schools
                          .where((school) =>
                              school.schoolName ==
                              context.read<AuthCubit>().defaultSchool)
                          .first
                          .schoolLogo,
                      height: 100,
                      width: 100,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
