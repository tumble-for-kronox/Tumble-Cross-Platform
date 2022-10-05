import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/ui/data/string_constants.dart';
import 'package:tumble/core/ui/schedule/tumble_list_view/data/custom_alerts.dart';
import 'package:tumble/core/ui/user/cubit/user_event_cubit.dart';

class AutoSignupOption extends StatelessWidget {
  const AutoSignupOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserEventCubit, UserEventState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          height: 55,
          child: SwitchListTile(
              activeColor: Theme.of(context).colorScheme.primary,
              title: Text(
                S.authorizedPage.automaticExamSignup(),
                style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
              ),
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
              value: BlocProvider.of<UserEventCubit>(context).state.autoSignup,
              onChanged: (value) {
                value
                    ? showCupertinoDialog(
                        context: context, builder: (_) => CustomAlertDialog.automaticExamSignupWarning(context, value))
                    : BlocProvider.of<UserEventCubit>(context).autoSignupToggle(value);
              }),
        );
      },
    );
  }
}
