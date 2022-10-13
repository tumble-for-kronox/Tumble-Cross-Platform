import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/ui/cubit/auth_cubit.dart';
import 'package:tumble/core/ui/tumble_loading.dart';
import 'package:tumble/core/ui/user/overview/authenticated_overview_page.dart';
import 'package:tumble/core/ui/user/overview/unauthenticated_overview_page.dart';

import '../cubit/resource_cubit.dart';
import '../cubit/user_event_cubit.dart';

class TumbleUserOverviewPageSwitch extends StatefulWidget {
  const TumbleUserOverviewPageSwitch({Key? key}) : super(key: key);

  @override
  State<TumbleUserOverviewPageSwitch> createState() => _TumbleUserOverviewPageSwitchState();
}

class _TumbleUserOverviewPageSwitchState extends State<TumbleUserOverviewPageSwitch> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        switch (state.status) {
          case AuthStatus.AUTHENTICATED:
            _initialiseUserData(context);
            return const AuthenticatedOverviewPage();
          case AuthStatus.INITIAL:
          case AuthStatus.ERROR:
          case AuthStatus.UNAUTHENTICATED:
            return const UnauthenticatedOverviewPage();
          default:
            return const TumbleLoading();
        }
      },
    );
  }

  void _initialiseUserData(BuildContext context) {
    if (context.read<AuthCubit>().state.status == AuthStatus.AUTHENTICATED) {
      context.read<UserEventCubit>().getUserEvents(
          context.read<AuthCubit>().state.status,
          context.read<AuthCubit>().login,
          context.read<AuthCubit>().logout,
          context.read<AuthCubit>().state.userSession!.sessionToken,
          true);
      context.read<ResourceCubit>().getSchoolResources(
            context.read<AuthCubit>().state.userSession!.sessionToken,
            context.read<AuthCubit>().login,
            context.read<AuthCubit>().logout,
          );
      context.read<ResourceCubit>().getUserBookings(
            context.read<AuthCubit>().state.userSession!.sessionToken,
            context.read<AuthCubit>().login,
            context.read<AuthCubit>().logout,
          );
    }
  }
}
