import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/models/api_models/available_user_event_model.dart';
import 'package:tumble/core/ui/account/user_event_list/user_event_register_button.dart';
import 'package:tumble/core/ui/data/string_constants.dart';
import 'package:tumble/core/ui/login/cubit/auth_cubit.dart';

import '../user_event_unregister_button.dart';

class AvailableUserEventCard extends StatelessWidget {
  final AvailableUserEventModel userEvent;
  final Null Function() onTap;

  const AvailableUserEventCard({Key? key, required this.userEvent, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 5),
        child: Stack(
          children: [
            Container(
              height: 140,
              width: double.infinity,
              margin: const EdgeInsets.only(top: 9, left: 10, right: 10),
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 2, offset: Offset(1, 1))]),
              child: MaterialButton(
                padding: const EdgeInsets.all(0),
                onPressed: onTap,
                child: Container(
                  padding: const EdgeInsets.only(left: 24, top: 15),
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 2),
                            child: Row(
                              children: [
                                Container(
                                  width: 5,
                                  height: 5,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.only(top: 1),
                                  child: Text(
                                    '${DateFormat('dd/MM/yy').format(userEvent.eventStart)}, ${DateFormat.Hm().format(userEvent.eventStart)} - ${DateFormat.Hm().format(userEvent.eventEnd)}',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        color: Theme.of(context).colorScheme.onSecondary,
                                        letterSpacing: .5),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 7.5,
                          ),
                          Text(userEvent.title.capitalize(),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onBackground,
                                fontSize: 19,
                                letterSpacing: .5,
                                fontWeight: FontWeight.w400,
                              )),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userEvent.isRegistered
                                      ? S.userEvents.unregisterUntil()
                                      : S.userEvents.registerBefore(),
                                  style: TextStyle(
                                      color: Theme.of(context).colorScheme.onSurface,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0.5),
                                ),
                                Text(
                                  DateFormat("dd-MM-yyyy").format(userEvent.lastSignupDate),
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.onBackground,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 10),
                              child: userEvent.isRegistered
                                  ? UserEventUnregisterButton(
                                      onPressed: () {
                                        BlocProvider.of<AuthCubit>(context).registerUserEvent(userEvent.id);
                                      },
                                    )
                                  : UserEventRegisterButton(
                                      linkToKronox: userEvent.requiresChoosingLocation,
                                      onPressed: () {
                                        BlocProvider.of<AuthCubit>(context).registerUserEvent(userEvent.id);
                                      }),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(top: 9, left: 10, right: 10),
                alignment: Alignment.topLeft,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius:
                        const BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                  ),
                  width: 8,
                  height: 140,
                )),
          ],
        ));
  }
}
