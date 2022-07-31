import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tumble/core/ui/main_app_widget/main_app_bottom_nav_bar/data/nav_bar_items.dart';

part 'navigation_state.dart';

class MainAppNavigationCubit extends Cubit<MainAppNavigationState> {
  MainAppNavigationCubit()
      : super(const MainAppNavigationState(NavbarItem.SEARCH, 0));

  void getNavBarItem(NavbarItem navbarItem) {
    switch (navbarItem) {
      case NavbarItem.SEARCH:
        emit(const MainAppNavigationState(NavbarItem.SEARCH, 0));
        break;
      case NavbarItem.LIST:
        emit(const MainAppNavigationState(NavbarItem.LIST, 1));
        break;
      case NavbarItem.WEEK:
        emit(const MainAppNavigationState(NavbarItem.WEEK, 2));
        break;
      case NavbarItem.CALENDAR:
        emit(const MainAppNavigationState(NavbarItem.CALENDAR, 3));
        break;
      case NavbarItem.USER_ACCOUNT:
        emit(const MainAppNavigationState(NavbarItem.USER_ACCOUNT, 4));
        break;
    }
  }
}
