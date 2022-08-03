import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tumble/core/ui/account/available_event_card.dart';
import 'package:tumble/core/ui/account/user_event_list/cubit/user_event_list_cubit.dart';
import 'package:tumble/core/ui/login/cubit/auth_cubit.dart';

class UserEventList extends StatefulWidget {
  const UserEventList({Key? key}) : super(key: key);

  @override
  State<UserEventList> createState() => _UserEventListState();
}

class _UserEventListState extends State<UserEventList> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen: ((_, current) =>
          current.userEventListStatus == UserEventListStatus.LOADING &&
          current.refreshSession),
      listener: (context, state) {
        BlocProvider.of<AuthCubit>(context).login();
        BlocProvider.of<AuthCubit>(context).getUserEvents(
            BlocProvider.of<AuthCubit>(context)
                .state
                .userSession!
                .sessionToken);
      },
      bloc: BlocProvider.of<AuthCubit>(context)
        ..getUserEvents(
          BlocProvider.of<AuthCubit>(context).state.userSession!.sessionToken,
        ),
      builder: (context, state) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
          ),
          child: Builder(
            builder: (context) {
              switch (state.userEventListStatus) {
                case UserEventListStatus.LOADING:
                  return SpinKitThreeBounce(
                      color: Theme.of(context).colorScheme.primary);
                case UserEventListStatus.LOADED:
                  return _loaded(context, state);
                case UserEventListStatus.ERROR:
                  return Text(
                    "We couldn't get your exams, try again in a bit.",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground),
                  );
              }
            },
          ),
        );
      },
    );
  }
}

Widget _loaded(BuildContext context, AuthState state) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      _availableUserEventsDivider(context, state),
      state.userEvents!.registeredEvents.isEmpty
          ? Text(
              "No exams available right now.",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            )
          : Container(),
      Column(
        children: state.userEvents!.unregisteredEvents.isNotEmpty
            ? state.userEvents!.unregisteredEvents
                .map((e) => AvailableEventCard(event: e))
                .toList()
            : state.userEvents!.registeredEvents
                .map((e) => AvailableEventCard(event: e))
                .toList(),
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "See all exams",
            style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 14),
          ),
          FloatingActionButton(
            onPressed: () => {},
            elevation: 0,
            child: const Icon(
              CupertinoIcons.chevron_down_circle,
              size: 25,
            ),
          ),
        ],
      ),
    ],
  );
}

Widget _availableUserEventsDivider(BuildContext context, AuthState state) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.only(right: 12),
        child: Text(
          state.userEvents!.unregisteredEvents.isNotEmpty
              ? "Available exams"
              : "Your upcoming exams",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
      Expanded(
        child: Divider(
          color: Theme.of(context).colorScheme.onBackground,
          thickness: 1,
        ),
      ),
      IconButton(
          padding: EdgeInsets.zero,
          color: Theme.of(context).colorScheme.primary,
          splashRadius: 24,
          onPressed: () => BlocProvider.of<AuthCubit>(context).getUserEvents(
                BlocProvider.of<AuthCubit>(context)
                    .state
                    .userSession!
                    .sessionToken,
              ),
          icon: const Icon(CupertinoIcons.refresh)),
    ],
  );
}

Widget _seeAllUserEvents(BuildContext context, AuthState state) {
  return TextButton(
      style: ButtonStyle(
        splashFactory: NoSplash.splashFactory,
        backgroundColor:
            MaterialStateProperty.resolveWith((states) => Colors.transparent),
      ),
      onPressed: () => {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "see all exams",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 2),
            child: Icon(
              CupertinoIcons.arrow_right,
              size: 14,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          )
        ],
      ));
}
