import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/api/backend/repository/cache_repository.dart';
import 'package:tumble/core/api/dependency_injection/get_it.dart';
import 'package:tumble/core/theme/cubit/theme_cubit.dart';
import 'package:tumble/core/theme/cubit/theme_state.dart';
import 'package:tumble/core/ui/app_switch/navigation_root_page.dart';
import 'package:tumble/core/ui/app_switch/school_selection_page.dart';
import 'package:tumble/core/ui/cubit/auth_cubit.dart';

class AppSwitch extends StatefulWidget {
  const AppSwitch({Key? key}) : super(key: key);
  @override
  State<AppSwitch> createState() => _AppSwitchState();
}

class _AppSwitchState extends State<AppSwitch> {
  final _cacheAndInteractionService = getIt<CacheRepository>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => runFirstTime());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return BlocProvider.value(
          value: context.read<AuthCubit>(),
          child: const NavigationRootPage(),
        );
      },
    );
  }

  Future<dynamic> runFirstTime() async {
    final hasRun = _cacheAndInteractionService.checkFirstTimeLaunch();
    if (!hasRun) {
      showModalBottomSheet(
          isScrollControlled: true,
          isDismissible: false,
          context: context,
          builder: (context) => const SchoolSelectionPage());
    }
  }
}
