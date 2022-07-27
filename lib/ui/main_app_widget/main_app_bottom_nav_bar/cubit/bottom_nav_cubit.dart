import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/shared/preference_types.dart';
import 'package:tumble/startup/get_it_instances.dart';
import 'package:tumble/ui/main_app_widget/main_app_bottom_nav_bar/data/nav_bar_items.dart';

part 'navigation_state.dart';

class MainAppNavigationCubit extends Cubit<MainAppNavigationState> {
  MainAppNavigationCubit() : super(const MainAppNavigationState(NavbarItem.SEARCH, 0));

  void getNavBarItem(NavbarItem navbarItem) {
    switch (navbarItem) {
      case NavbarItem.SEARCH:
        emit(const MainAppNavigationState(NavbarItem.SEARCH, 0));
        break;
      case NavbarItem.USER_ACCOUNT:
        emit(const MainAppNavigationState(NavbarItem.USER_ACCOUNT, 1));
        break;
      case NavbarItem.LIST:
        emit(const MainAppNavigationState(NavbarItem.LIST, 2));
        break;
      case NavbarItem.WEEK:
        emit(const MainAppNavigationState(NavbarItem.WEEK, 3));
        break;
      case NavbarItem.CALENDAR:
        emit(const MainAppNavigationState(NavbarItem.CALENDAR, 4));
        break;
    }
  }
}
