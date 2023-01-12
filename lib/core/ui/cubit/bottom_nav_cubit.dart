import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tumble/core/ui/bottom_nav_bar/data/nav_bar_items.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit()
      : super(const NavigationState(
          navbarItem: NavbarItem.search,
          index: 0,
          previewToggle: false,
        ));

  void getNavBarItem(NavbarItem navbarItem) {
    emit(NavigationState(
        navbarItem: navbarItem, index: navbarItem.index, previewToggle: false));
  }

  void setPreviewToggle() {
    emit(state.copyWith(previewToggle: true));
  }
}
