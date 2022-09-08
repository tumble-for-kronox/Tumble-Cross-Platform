import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/navigation/app_navigator.dart';
import 'package:tumble/core/navigation/navigation_route_labels.dart';
import 'package:tumble/core/shared/preference_types.dart';
import 'package:tumble/core/dependency_injection/get_it_instances.dart';
import 'package:tumble/core/ui/user/overview/user_info.dart';

class UnauthenticatedOverviewPage extends StatelessWidget {
  const UnauthenticatedOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigator = BlocProvider.of<AppNavigator>(context);
    return UserInfo(
        loggedIn: false,
        onPressed: () => navigator.push(NavigationRouteLabels.loginPageRoot,
            arguments:
                getIt<SharedPreferences>().getString(PreferenceTypes.school)));
  }
}
