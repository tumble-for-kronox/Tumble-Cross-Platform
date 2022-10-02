import 'package:flutter/cupertino.dart';
import 'package:tumble/core/app.dart';
import 'package:tumble/core/navigation/navigation_route_labels.dart';
import 'package:tumble/core/ui/login/login_page_root.dart';
import 'package:tumble/core/ui/app_switch/app_switch.dart';
import 'package:tumble/core/ui/app_switch/initialized_navigation_root_page.dart';
import 'package:tumble/core/ui/app_switch/school_selection_page.dart';
import 'package:tumble/core/ui/schedule/tumble_calendar_view/tumble_calendar_view.dart';
import 'package:tumble/core/ui/schedule/tumble_list_view/tumble_list_view.dart';
import 'package:tumble/core/ui/schedule/tumble_week_view/tumble_week_view.dart';
import 'package:tumble/core/ui/search/search/tumble_search_page.dart';
import 'package:tumble/core/ui/user/resources/tumble_chosen_resource_page.dart';
import 'package:tumble/core/ui/user/resources/tumble_resource_page.dart';

class Routes {
  Routes._();

  static List<String> pages = [
    NavigationRouteLabels.appSwitchPage,
    NavigationRouteLabels.mainAppNavigationRootPage,
    NavigationRouteLabels.schoolSelectionPage,
    NavigationRouteLabels.loginPageRoot,
    NavigationRouteLabels.tumbleSearchPage,
    NavigationRouteLabels.tumbleListView,
    NavigationRouteLabels.tumbleWeekView,
    NavigationRouteLabels.tumbleCalendarView,
    NavigationRouteLabels.appTopRootBuilder,
    NavigationRouteLabels.resourceBasePage,
    NavigationRouteLabels.chosenResourcePage,
  ];

  static Page getPage(String page, {dynamic arguments}) {
    dynamic pageClass;
    switch (page) {
      case NavigationRouteLabels.appSwitchPage:
        pageClass = const AppSwitch();
        break;
      case NavigationRouteLabels.mainAppNavigationRootPage:
        pageClass = const InitializedNavigationRootPage();
        break;
      case NavigationRouteLabels.schoolSelectionPage:
        pageClass = const SchoolSelectionPage();
        break;
      case NavigationRouteLabels.loginPageRoot:
        pageClass = LoginPageRoot(
          schoolName: arguments,
        );
        break;
      case NavigationRouteLabels.tumbleSearchPage:
        pageClass = const TumbleSearchPage();
        break;
      case NavigationRouteLabels.tumbleListView:
        pageClass = const TumbleListView();
        break;
      case NavigationRouteLabels.tumbleWeekView:
        pageClass = const TumbleWeekView();
        break;
      case NavigationRouteLabels.tumbleCalendarView:
        pageClass = const TumbleCalendarView();
        break;
      case NavigationRouteLabels.appTopRootBuilder:
        pageClass = const App();
        break;
      case NavigationRouteLabels.resourceBasePage:
        pageClass = const ResourcePage();
        break;
      default:
        return CupertinoPage(
          key: const ValueKey('blankPage'),
          name: 'blankPage',
          child: Container(),
        );
    }
    return CupertinoPage(
      key: ValueKey(page),
      name: page,
      child: pageClass,
      arguments: arguments,
    );
  }
}
