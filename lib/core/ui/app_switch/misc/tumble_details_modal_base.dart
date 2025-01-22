import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/ui/app_switch/misc/tumble_drag_pill.dart';

class TumbleDetailsModalBase extends StatelessWidget {
  final Widget body;
  final Function()? onSettingsPressed;
  final String title;
  final Color barColor;

  const TumbleDetailsModalBase(
      {super.key, required this.body, required this.title, required this.barColor, this.onSettingsPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 280,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(padding: const EdgeInsets.only(top: 10), child: body),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              alignment: Alignment.center,
              width: double.maxFinite,
              height: 54,
              decoration: BoxDecoration(
                color: barColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
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
          TumbleDragPill(
            barColor: barColor.contrastColor(),
          ),
          () {
            return onSettingsPressed == null
                ? Container()
                : Container(
                    padding: const EdgeInsets.only(top: 5),
                    child: Align(
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
                    ),
                  );
          }(),
        ],
      ),
    );
  }
}
