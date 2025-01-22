import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tumble/core/api/backend/repository/cache_repository.dart';
import 'package:tumble/core/api/dependency_injection/get_it.dart';
import 'package:tumble/core/ui/data/string_constants.dart';

class PermissionHandler extends StatelessWidget {
  final _cacheAndInteractionService = getIt<CacheRepository>();

  PermissionHandler({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      actions: [
        CupertinoDialogAction(
            child: TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  await _cacheAndInteractionService.permissionRequest(false);
                },
                child: Text(S.general.no(),
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    )))),
        CupertinoDialogAction(
          child: TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _cacheAndInteractionService.permissionRequest(true);
              },
              child: Text(S.general.yes(),
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ))),
        )
      ],
      content: Column(
        mainAxisSize: MainAxisSize.min, // To make the card compact
        children: <Widget>[
          Align(
              alignment: Alignment.topLeft,
              child: Text(
                S.popUps.notificationRequestTitle(),
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                ),
              )),
          const SizedBox(height: 24.0),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              S.popUps.notificationRequestDescription(),
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
