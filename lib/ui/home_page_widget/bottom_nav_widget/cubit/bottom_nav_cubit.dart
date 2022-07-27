import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumble/shared/preference_types.dart';
import 'package:tumble/startup/get_it_instances.dart';
import 'package:tumble/ui/home_page_widget/bottom_nav_widget/data/nav_bar_items.dart';

part 'navigation_state.dart';

class HomePageNavigationCubit extends Cubit<HomePageNavigationState> {
  HomePageNavigationCubit()
      : super(HomePageNavigationState(
            HomePageNavbarItem.values[
                locator<SharedPreferences>().getInt(PreferenceTypes.view)!],
            locator<SharedPreferences>().getInt(PreferenceTypes.view)!));

  void getNavBarItem(HomePageNavbarItem navbarItem) {
    switch (navbarItem) {
      case HomePageNavbarItem.LIST:
        emit(const HomePageNavigationState(HomePageNavbarItem.LIST, 0));
        break;
      case HomePageNavbarItem.WEEK:
        emit(const HomePageNavigationState(HomePageNavbarItem.WEEK, 1));
        break;
      case HomePageNavbarItem.CALENDAR:
        emit(const HomePageNavigationState(HomePageNavbarItem.CALENDAR, 2));
        break;
    }
  }
}
