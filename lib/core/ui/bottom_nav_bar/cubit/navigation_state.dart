part of 'bottom_nav_cubit.dart';

class MainAppNavigationState extends Equatable {
  final NavbarItem navbarItem;
  final bool previewToggle;
  final int index;

  const MainAppNavigationState(
      {required this.navbarItem,
      required this.index,
      required this.previewToggle});

  MainAppNavigationState copyWith(
          {NavbarItem? navbarItem, bool? previewToggle, int? index}) =>
      MainAppNavigationState(
        navbarItem: navbarItem ?? this.navbarItem,
        index: index ?? this.index,
        previewToggle: previewToggle ?? this.previewToggle,
      );

  @override
  List<Object> get props => [
        navbarItem,
        index,
        previewToggle,
      ];
}
