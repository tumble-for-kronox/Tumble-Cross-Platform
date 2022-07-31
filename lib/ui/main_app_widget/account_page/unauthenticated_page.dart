import 'package:flutter/cupertino.dart';
import 'package:tumble/ui/main_app_widget/account_page/widgets/user_info.dart';
import 'package:tumble/ui/main_app_widget/login_page/login_page_root.dart';

class UnauthenticatedPage extends StatelessWidget {
  const UnauthenticatedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UserInfo(
        loggedIn: false,
        onPressed: () => Navigator.of(context).push(CupertinoPageRoute(builder: (context) => const LoginPageRoot())));
  }
}
