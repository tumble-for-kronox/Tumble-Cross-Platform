import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/refactor/core/navigation/navigation_routes.dart';

class AppNavigator extends Cubit<List<Page>> {
  AppNavigator() : super([]);

  void init(List<String> pages) {
    List<Page> list = [];
    for (String page in pages) {
      if (Routes.pages.contains(page)) {
        list.add(Routes.getPage(page));
      }
    }
    emit(list);
  }

  bool push(String page, {dynamic arguments}) {
    List<Page> list = List.from(state);
    if (list.last.name == page && list.last.arguments == arguments) {
      return false;
    }
    list.add(Routes.getPage(page, arguments: arguments));
    emit(list);
    return true;
  }

  bool pushReplace(String page, {dynamic arguments}) {
    List<Page> list = List.from(state);
    if (list.length <= 1) return false;
    if (list.last.name == page && list.last.arguments == arguments) {
      return false;
    }
    list.removeLast();
    list.add(Routes.getPage(page, arguments: arguments));
    emit(list);
    return true;
  }

  bool pushAndRemoveUntil(String page,
      {required String lastPage, dynamic arguments}) {
    List<Page> list = List.from(state);
    if (list.length <= 1) return false;
    if (list.last.name == page && list.last.arguments == arguments) {
      return false;
    }
    final index = list.indexWhere((item) => lastPage == item.name);
    if (index < 0) return false;
    list.removeRange(index + 1, list.length);
    list.add(Routes.getPage(page, arguments: arguments));
    emit(list);
    return true;
  }

  bool pushAndRemoveAll(String page, {dynamic arguments}) {
    List<Page> list = List.from(state);
    if (list.last.name == page && list.last.arguments == arguments) {
      return false;
    }
    list.clear();
    list.add(Routes.getPage(page, arguments: arguments));
    emit(list);
    return true;
  }

  bool pop() {
    List<Page> list = List.from(state);
    if (list.length <= 1) return false;
    list.removeLast();
    emit(list);
    return true;
  }

  bool popUntil(String page) {
    List<Page> list = List.from(state);
    if (list.length <= 1) return false;
    final index = list.indexWhere((item) => page == item.name);
    if (index < 0) return false;
    list.removeRange(index + 1, list.length);
    emit(list);
    return true;
  }

  bool addAfter(String page, {required String afterPage, dynamic arguments}) {
    List<Page> list = List.from(state);
    final index = list.indexWhere((item) => afterPage == item.name);
    if (index < 0) return false;
    list.insert(index + 1, Routes.getPage(page, arguments: arguments));
    emit(list);
    return true;
  }

  bool remove(String page) {
    List<Page> list = List.from(state);
    if (list.length <= 1) return false;
    list.removeWhere((item) => page == item.name);
    emit(list);
    return true;
  }
}
