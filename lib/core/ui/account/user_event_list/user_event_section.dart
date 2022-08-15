import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../login/cubit/auth_cubit.dart';

class UserEventSection extends StatelessWidget {
  final String sectionTitle;

  const UserEventSection({Key? key, required this.sectionTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      return Column(
        children: [_eventsDivider(context, state, sectionTitle)],
      );
    });
  }
}

Widget _eventsDivider(BuildContext context, AuthState state, String title) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.only(right: 12),
        child: Text(
          title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
            fontWeight: FontWeight.w500,
            fontSize: 16,
            letterSpacing: 1.2,
          ),
        ),
      ),
      Expanded(
        child: Divider(
          color: Theme.of(context).colorScheme.onBackground,
          thickness: 1,
        ),
      ),
    ],
  );
}
