import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class LocationCardContainer extends StatelessWidget {
  final List<Widget> cards;
  final int maxRowItems;

  const LocationCardContainer({super.key, required this.cards, required this.maxRowItems});

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        shrinkWrap: true,
        crossAxisCount: maxRowItems,
        children: List.generate(cards.length, (index) {
          return AnimationConfiguration.staggeredGrid(
              position: index,
              columnCount: maxRowItems,
              child: FadeInAnimation(
                child: cards[index],
              ));
        }),
      ),
    );
  }
}
