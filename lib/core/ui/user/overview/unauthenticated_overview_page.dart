import 'package:flutter/cupertino.dart';
import 'package:tumble/core/api/shared_preferences/shared_preference_service.dart';
import 'package:tumble/core/navigation/navigation_route_labels.dart';
import 'package:tumble/core/api/dependency_injection/get_it.dart';
import 'package:tumble/core/ui/user/overview/user_info.dart';

class UnauthenticatedOverviewPage extends StatelessWidget {
  const UnauthenticatedOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UserInfo(
        loggedIn: false,
        onPressed: () => Navigator.of(context)
                .pushNamed(NavigationRouteLabels.loginPageRoot, arguments: {
              'schoolName': getIt<SharedPreferenceService>().defaultSchool
            }));
  }
}
