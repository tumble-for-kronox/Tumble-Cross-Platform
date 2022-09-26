import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class TimeStampContainer extends StatelessWidget {
  final List<Widget> cards;
  final int maxRowItems;

  const TimeStampContainer({Key? key, required this.cards, required this.maxRowItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 20),
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 3 / 1,
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
