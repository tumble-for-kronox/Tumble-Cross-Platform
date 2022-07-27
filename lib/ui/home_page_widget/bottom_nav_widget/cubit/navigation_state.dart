part of 'bottom_nav_cubit.dart';

class HomePageNavigationState extends Equatable {
  final HomePageNavbarItem navbarItem;
  final int index;

  const HomePageNavigationState(this.navbarItem, this.index);

  @override
  List<Object> get props => [navbarItem, index];
}
