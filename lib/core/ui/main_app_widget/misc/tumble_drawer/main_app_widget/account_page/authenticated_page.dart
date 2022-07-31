import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/ui/main_app_widget/misc/tumble_drawer/auth_cubit/auth_cubit.dart';
import 'package:tumble/core/ui/main_app_widget/misc/tumble_drawer/main_app_widget/account_page/user_event_list/user_event_list.dart';
import 'package:tumble/core/ui/main_app_widget/misc/tumble_drawer/main_app_widget/account_page/widgets/user_info.dart';

class AuthenticatedPage extends StatelessWidget {
  const AuthenticatedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UserInfo(
          name: BlocProvider.of<AuthCubit>(context).state.userSession!.name,
          loggedIn: true,
          onPressed: BlocProvider.of<AuthCubit>(context).logout,
        ),
        const UserEventList(),
      ],
    );
  }
}
