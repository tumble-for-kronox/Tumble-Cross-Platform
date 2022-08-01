import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/core/navigation/app_navigator.dart';
import 'package:tumble/core/navigation/navigation_route_labels.dart';
import 'package:tumble/core/shared/preference_types.dart';
import 'package:tumble/core/startup/get_it_instances.dart';
import 'package:tumble/core/ui/main_app_widget/login_page/login_page_root.dart';
import 'package:tumble/core/ui/main_app_widget/misc/tumble_drawer/main_app_widget/account_page/widgets/user_info.dart';

class UnauthenticatedPage extends StatelessWidget {
  const UnauthenticatedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigator = BlocProvider.of<AppNavigator>(context);
    return UserInfo(
        loggedIn: false,
        onPressed: () => navigator.push(NavigationRouteLabels.loginPageRoot,
            arguments: locator<SharedPreferences>()
                .getString(PreferenceTypes.school)));
  }
}
