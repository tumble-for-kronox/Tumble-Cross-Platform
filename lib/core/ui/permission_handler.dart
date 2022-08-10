import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:tumble/core/ui/main_app/cubit/main_app_cubit.dart';

class PermissionHandler extends StatelessWidget {
  final MainAppCubit cubit;
  const PermissionHandler({Key? key, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(22.0)),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      contentPadding:
          const EdgeInsets.only(top: 19, bottom: 10, left: 17, right: 10),
      content: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(Radius.circular(20.0))),
        child: Column(
          mainAxisSize: MainAxisSize.min, // To make the card compact
          children: <Widget>[
            const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Allow notifications",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                  ),
                )),
            const SizedBox(height: 24.0),
            const Align(
              alignment: Alignment.center,
              child: Text(
                "This app would like to send you notifications",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(height: 15.0),
            Align(
              alignment: Alignment.bottomRight,
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Align(
                  child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("No",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                          ))),
                ),
                Align(
                  child: TextButton(
                      onPressed: () async {
                        Navigator.of(context).pop();
                        await cubit.permissionRequest();
                      },
                      child: const Text("Yes",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                          ))),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
