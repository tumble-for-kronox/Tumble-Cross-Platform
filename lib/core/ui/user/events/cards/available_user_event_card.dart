import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/models/backend_models/available_user_event_model.dart';
import 'package:tumble/core/ui/cubit/auth_cubit.dart';
import 'package:tumble/core/ui/cubit/user_event_cubit.dart';
import 'package:tumble/core/ui/data/string_constants.dart';
import 'package:tumble/core/ui/user/events/user_event_register_button.dart';

import '../user_event_unregister_button.dart';

class AvailableUserEventCard extends StatefulWidget {
  final AvailableUserEventModel userEvent;
  final Null Function() onTap;

  const AvailableUserEventCard({
    Key? key,
    required this.userEvent,
    required this.onTap,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AvailableUserEventCard();
}

class _AvailableUserEventCard extends State<AvailableUserEventCard> {
  bool loadingCard = false;

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
                  borderRadius: BorderRadius.circular(7.5),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 1,
                        offset: Offset(0, .5))
                  ]),
              child: MaterialButton(
                padding: const EdgeInsets.all(0),
                onPressed: widget.onTap,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.5),
                ),
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
                            padding: const EdgeInsets.only(left: 2, right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 5,
                                      height: 5,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      '${DateFormat.Hm(Localizations.localeOf(context).languageCode).format(widget.userEvent.eventStart)} - ${DateFormat.Hm(Localizations.localeOf(context).languageCode).format(widget.userEvent.eventEnd)}',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary,
                                          letterSpacing: .5),
                                    ),
                                  ],
                                ),
                                Text(
                                  DateFormat(
                                          'dd-MM-yyyy',
                                          Localizations.localeOf(context)
                                              .languageCode)
                                      .format(widget.userEvent.eventStart),
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                      letterSpacing: .5),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 7.5,
                          ),
                          Text(widget.userEvent.title.capitalize(),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
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
                                  widget.userEvent.isRegistered
                                      ? S.userEvents.unregisterUntil()
                                      : S.userEvents.registerBefore(),
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.5),
                                ),
                                Text(
                                  DateFormat(
                                          "dd-MM-yyyy",
                                          Localizations.localeOf(context)
                                              .languageCode)
                                      .format(widget.userEvent.lastSignupDate),
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(
                                    right: 10, bottom: 10),
                                child:
                                    BlocBuilder<UserEventCubit, UserEventState>(
                                  builder: (context, state) {
                                    return widget.userEvent.isRegistered
                                        ? UserEventUnregisterButton(
                                            loading: loadingCard,
                                            onPressed: () {
                                              setLoading();
                                              unregisterUserEvent();
                                            },
                                          )
                                        : UserEventRegisterButton(
                                            loading: loadingCard,
                                            linkToKronox: widget.userEvent
                                                .requiresChoosingLocation,
                                            onPressed: () {
                                              setLoading();
                                              registerUserEvent();
                                            });
                                  },
                                )),
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
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        bottomLeft: Radius.circular(5)),
                  ),
                  width: 8,
                  height: 140,
                )),
          ],
        ));
  }

  void setLoading() => loadingCard = true;

  void unregisterUserEvent() {
    BlocProvider.of<UserEventCubit>(context).unregisterUserEvent(
      widget.userEvent.id,
      context.read<AuthCubit>().state.status,
      context.read<AuthCubit>().setUserSession,
      context.read<AuthCubit>().logout,
      context.read<AuthCubit>().state.userSession!,
    );
  }

  void registerUserEvent() {
    BlocProvider.of<UserEventCubit>(context).registerUserEvent(
      context.read<AuthCubit>().state.status,
      widget.userEvent.id,
      context.read<AuthCubit>().setUserSession,
      context.read<AuthCubit>().logout,
      context.read<AuthCubit>().state.userSession!,
    );
  }
}
