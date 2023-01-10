import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/models/ui_models/school_model.dart';
import 'package:tumble/core/theme/cubit/theme_cubit.dart';
import 'package:tumble/core/theme/cubit/theme_state.dart';
import 'package:tumble/core/ui/app_switch/navigation_root_page.dart';
import 'package:tumble/core/ui/app_switch/school_selection_page.dart';
import 'package:tumble/core/ui/cubit/app_switch_cubit.dart';
import 'package:tumble/core/ui/cubit/auth_cubit.dart';
import 'package:tumble/core/ui/tumble_loading.dart';

class AppSwitch extends StatefulWidget {
  const AppSwitch({Key? key}) : super(key: key);

  @override
  State<AppSwitch> createState() => _AppSwitchState();
}

class _AppSwitchState extends State<AppSwitch> {
  late AppSwitchCubit _appSwitchCubit;

  @override
  void initState() {
    _appSwitchCubit = AppSwitchCubit();
    WidgetsBinding.instance.addPostFrameCallback((_) => runFirstTime());
    super.initState();
  }

  @override
  void dispose() {
    _appSwitchCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
        builder: ((context, state) => BlocProvider.value(
              value: _appSwitchCubit,
              child: BlocBuilder<AppSwitchCubit, AppSwitchState>(
                builder: (context, state) {
                  return BlocProvider.value(
                    value: context.read<AuthCubit>(),
                    child: const NavigationRootPage(),
                  );
                },
              ),
            )));
  }

  Future<dynamic> runFirstTime() async {
    final hasRun = _appSwitchCubit.checkFirstTimeLaunch();
    if (!hasRun) {
      showModalBottomSheet(
          isScrollControlled: true,
          isDismissible: false,
          context: context,
          builder: (context) => BlocProvider.value(
                value: _appSwitchCubit,
                child: const SchoolSelectionPage(),
              ));
      _appSwitchCubit.setFirstTimeLaunched(true);
    }
  }
}
