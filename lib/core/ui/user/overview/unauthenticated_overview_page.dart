import 'package:flutter/cupertino.dart';
import 'package:tumble/core/api/preferences/repository/preference_repository.dart';
import 'package:tumble/core/navigation/navigation_route_labels.dart';
import 'package:tumble/core/api/dependency_injection/get_it.dart';
import 'package:tumble/core/ui/user/overview/user_info.dart';

class UnauthenticatedOverviewPage extends StatelessWidget {
  const UnauthenticatedOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return UserInfo(
        loggedIn: false,
        onPressed: () => Navigator.of(context).pushNamed(NavigationRouteLabels.loginPageRoot,
            arguments: {'schoolName': getIt<PreferenceRepository>().defaultSchool}));
  }
}
