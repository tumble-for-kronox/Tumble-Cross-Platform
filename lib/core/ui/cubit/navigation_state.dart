part of 'bottom_nav_cubit.dart';

class NavigationState extends Equatable {
  final NavbarItem navbarItem;
  final bool previewToggle;
  final int index;

  const NavigationState({required this.navbarItem, required this.index, required this.previewToggle});

  NavigationState copyWith({NavbarItem? navbarItem, bool? previewToggle, int? index}) => NavigationState(
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
