import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/ui/schedule/event_options.dart';

class DetailsModal extends StatelessWidget {
  final Widget body;
  final Function()? onSettingsPressed;
  final String title;
  final Color barColor;

  const DetailsModal(
      {Key? key, required this.body, required this.title, required this.barColor, this.onSettingsPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 260,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          body,
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              alignment: Alignment.center,
              width: double.maxFinite,
              height: 50,
              decoration: BoxDecoration(
                color: barColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    color: barColor.contrastColor(),
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.only(top: 5),
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: barColor.contrastColor().withOpacity(0.5),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          () {
            return onSettingsPressed == null
                ? Container()
                : Align(
                    alignment: Alignment.topRight,
                    child: Material(
                      color: Colors.transparent,
                      child: IconButton(
                        splashRadius: 20,
                        color: barColor.contrastColor(),
                        onPressed: onSettingsPressed,
                        icon: const Icon(CupertinoIcons.ellipsis),
                      ),
                    ),
                  );
          }(),
        ],
      ),
    );
  }
}
