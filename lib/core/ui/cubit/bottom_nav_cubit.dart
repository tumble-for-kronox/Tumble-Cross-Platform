import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tumble/core/ui/bottom_nav_bar/data/nav_bar_items.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit()
      : super(const NavigationState(
          navbarItem: NavbarItem.SEARCH,
          index: 0,
          previewToggle: false,
        ));

  void getNavBarItem(NavbarItem navbarItem) {
    switch (navbarItem) {
      case NavbarItem.SEARCH:
        emit(const NavigationState(navbarItem: NavbarItem.SEARCH, index: 0, previewToggle: false));
        break;
      case NavbarItem.LIST:
        emit(const NavigationState(navbarItem: NavbarItem.LIST, index: 1, previewToggle: false));
        break;
      case NavbarItem.WEEK:
        emit(const NavigationState(navbarItem: NavbarItem.WEEK, index: 2, previewToggle: false));
        break;
      case NavbarItem.CALENDAR:
        emit(const NavigationState(navbarItem: NavbarItem.CALENDAR, index: 3, previewToggle: false));
        break;
      case NavbarItem.USER_OVERVIEW:
        emit(const NavigationState(navbarItem: NavbarItem.USER_OVERVIEW, index: 4, previewToggle: false));
        break;
    }
  }

  void setPreviewToggle() {
    emit(state.copyWith(previewToggle: true));
  }
}
