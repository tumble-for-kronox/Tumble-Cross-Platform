import 'package:flutter/cupertino.dart';
import 'package:tumble/ui/main_app_widget/main_app.dart';
import 'package:tumble/ui/main_app_widget/main_app_navigation_root.dart';
import 'package:tumble/ui/main_app_widget/school_selection_page.dart';

class Routes {
  Routes._();

  static List<String> pages = [
    'aPage',
    'bPage',
    'cPage',
    'a1Page',
    'a2Page',
    'a3Page',
  ];

  static Page getPage(String page, {dynamic arguments}) {
    dynamic pageClass;
    switch (page) {
      case 'MainAppPage':
        pageClass = const MainApp();
        break;
      case 'MainAppNavigationRootPage':
        pageClass = const MainAppNavigationRootPage();
        break;
      case 'SchoolSelectionPage':
        pageClass = const SchoolSelectionPage();
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
