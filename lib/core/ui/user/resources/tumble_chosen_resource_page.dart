import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class TumbleChosenResourcePage extends StatelessWidget {
  const TumbleChosenResourcePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
          return true;
        }
        return false;
      },
      child: SafeArea(
        child: Container(),
      ),
    );
  }
}
