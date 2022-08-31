import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/ui/data/string_constants.dart';
import 'package:tumble/core/ui/login/cubit/auth_cubit.dart';
import 'package:tumble/core/ui/schedule/tumble_list_view/data/cupertino_alerts.dart';

class AutoSignupOption extends StatelessWidget {
  const AutoSignupOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          height: 55,
          child: SwitchListTile(
              title: Text(
                S.authorizedPage.automaticExamSignup(),
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              value: BlocProvider.of<AuthCubit>(context).state.autoSignup,
              onChanged: (value) {
                value
                    ? showCupertinoDialog(
                        context: context,
                        builder: (context) =>
                            CustomAlertDialog.automaticExamSignupWarning(
                                context, value))
                    : BlocProvider.of<AuthCubit>(context)
                        .autoSignupToggle(value);
                ;
              }),
        );
      },
    );
  }
}
