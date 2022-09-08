import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/ui/login/cubit/auth_cubit.dart';
import 'package:tumble/core/ui/tumble_loading.dart';
import 'package:tumble/core/ui/user/overview/authenticated_overview_page.dart';
import 'package:tumble/core/ui/user/overview/unauthenticated_overview_page.dart';

class TumbleUserOverviewPageSwitch extends StatefulWidget {
  const TumbleUserOverviewPageSwitch({Key? key}) : super(key: key);

  @override
  State<TumbleUserOverviewPageSwitch> createState() =>
      _TumbleUserOverviewPageSwitchState();
}

class _TumbleUserOverviewPageSwitchState
    extends State<TumbleUserOverviewPageSwitch> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        switch (state.status) {
          case AuthStatus.AUTHENTICATED:
            return const AuthenticatedOverviewPage();
          case AuthStatus.INITIAL:
          case AuthStatus.UNAUTHENTICATED:
            return const UnauthenticatedOverviewPage();
          default:
            return const TumbleLoading();
        }
      },
    );
  }
}
