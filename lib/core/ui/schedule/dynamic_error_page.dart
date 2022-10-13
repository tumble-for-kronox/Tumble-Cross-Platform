import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/ui/bottom_nav_bar/data/nav_bar_items.dart';
import 'package:tumble/core/ui/cubit/bottom_nav_cubit.dart';
import 'package:tumble/core/ui/data/string_constants.dart';

class DynamicErrorPage extends StatefulWidget {
  final String errorType;
  final bool toSearch;
  final String? description;
  const DynamicErrorPage({Key? key, required this.errorType, this.description, required this.toSearch})
      : super(key: key);

  @override
  State<DynamicErrorPage> createState() => _DynamicErrorPageState();
}

class _DynamicErrorPageState extends State<DynamicErrorPage> with TickerProviderStateMixin {
  late final AnimationController _controllerFirst = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );
  late final AnimationController _controllerSecond = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  );
  late final Animation<double> _infoAnimation = CurvedAnimation(
    parent: _controllerSecond,
    curve: Curves.decelerate,
  );
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(3, 0.0),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _controllerFirst,
    curve: Curves.fastLinearToSlowEaseIn,
  ));

  @override
  void initState() {
    super.initState();
    firstAnim().then((_) => secondAnim());
  }

  Future<void> firstAnim() async {
    await _controllerFirst.reverse();
    await _controllerFirst.forward();
  }

  void secondAnim() async {
    await _controllerSecond.forward();
  }

  @override
  void dispose() {
    _controllerFirst.dispose();
    _controllerSecond.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SlideTransition(
            position: _offsetAnimation,
            child: Text(widget.errorType,
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground, fontSize: 30, fontWeight: FontWeight.w500)),
          ),
          const SizedBox(
            height: 80,
          ),
          FadeTransition(
            opacity: _infoAnimation,
            child: Column(
              children: [
                Text(widget.description!,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground, fontSize: 18, fontWeight: FontWeight.w500)),
                const SizedBox(
                  height: 20,
                ),
                if (widget.toSearch)
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton.icon(
                        onPressed: () => context.read<NavigationCubit>().getNavBarItem(NavbarItem.SEARCH),
                        icon: const Icon(CupertinoIcons.chevron_left),
                        label: Text(S.general.toSearch())),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
