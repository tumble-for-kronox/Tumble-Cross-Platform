part of 'bottom_nav_cubit.dart';

class MainAppNavigationState extends Equatable {
  final NavbarItem navbarItem;
  final int index;

  const MainAppNavigationState(this.navbarItem, this.index);

  @override
  List<Object> get props => [navbarItem, index];
}
