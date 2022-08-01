import 'package:flutter/cupertino.dart';
import 'package:tumble/core/navigation/navigation_route_labels.dart';
import 'package:tumble/core/ui/main_app_widget/login_page/login_page_root.dart';
import 'package:tumble/core/ui/main_app.dart';
import 'package:tumble/core/ui/main_app_widget/main_app_navigation_root.dart';
import 'package:tumble/core/ui/main_app_widget/schedule_view_widgets/tumble_calendar_view/tumble_calendar_view.dart';
import 'package:tumble/core/ui/main_app_widget/schedule_view_widgets/tumble_list_view/tumble_list_view.dart';
import 'package:tumble/core/ui/main_app_widget/schedule_view_widgets/tumble_week_view/tumble_week_view.dart';
import 'package:tumble/core/ui/main_app_widget/school_selection_page.dart';
import 'package:tumble/core/ui/main_app_widget/search_page_widgets/search/tumble_search_page.dart';

class Routes {
  Routes._();

  static List<String> pages = [
    NavigationRouteLabels.mainAppPage,
    NavigationRouteLabels.mainAppNavigationRootPage,
    NavigationRouteLabels.schoolSelectionPage,
    NavigationRouteLabels.loginPageRoot,
    NavigationRouteLabels.tumbleSearchPage,
    NavigationRouteLabels.tumbleListView,
    NavigationRouteLabels.tumbleWeekView,
    NavigationRouteLabels.tumbleCalendarView,
  ];

  static Page getPage(String page, {dynamic arguments}) {
    dynamic pageClass;
    switch (page) {
      case NavigationRouteLabels.mainAppPage:
        pageClass = const MainApp();
        break;
      case NavigationRouteLabels.mainAppNavigationRootPage:
        pageClass = const MainAppNavigationRootPage();
        break;
      case NavigationRouteLabels.schoolSelectionPage:
        pageClass = const SchoolSelectionPage();
        break;
      case NavigationRouteLabels.loginPageRoot:
        pageClass = LoginPageRoot(
          school: arguments,
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
