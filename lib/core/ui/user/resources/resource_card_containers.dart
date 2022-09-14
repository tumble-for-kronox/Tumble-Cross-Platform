import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ResourceCardContainer extends StatelessWidget {
  final List<Widget> cards;
  final int maxRowItems;

  const ResourceCardContainer({Key? key, required this.cards, required this.maxRowItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      child: GridView.count(
        crossAxisCount: maxRowItems,
        children: cards,
      ),
    );
  }
}
