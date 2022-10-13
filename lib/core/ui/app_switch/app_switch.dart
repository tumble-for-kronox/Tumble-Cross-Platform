import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  /// Global Cubit instances
  @override
  void initState() {
    _appSwitchCubit = AppSwitchCubit();
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
                  switch (state.status) {
                    case AppSwitchStatus.UNINITIALIZED:
                      return MultiBlocProvider(
                        providers: [
                          BlocProvider.value(
                            value: context.read<AuthCubit>(),
                          ),
                          BlocProvider.value(
                            value: _appSwitchCubit,
                          ),
                        ],
                        child: const SchoolSelectionPage(),
                      );
                    case AppSwitchStatus.INITIALIZED:
                      return BlocProvider.value(
                        value: context.read<AuthCubit>(),
                        child: const NavigationRootPage(),
                      );
                    default:
                      return const TumbleLoading();
                  }
                },
              ),
            )));
  }
}
