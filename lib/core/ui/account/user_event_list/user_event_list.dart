import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tumble/core/ui/account/user_event_list/user_event_section.dart';
import 'package:tumble/core/ui/data/string_constants.dart';
import 'package:tumble/core/ui/login/cubit/auth_cubit.dart';
import 'package:tumble/core/ui/tumble_loading.dart';

class UserEventList extends StatefulWidget {
  const UserEventList({Key? key}) : super(key: key);

  @override
  State<UserEventList> createState() => _UserEventListState();
}

class _UserEventListState extends State<UserEventList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          height: double.maxFinite,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Builder(
            builder: (context) {
              switch (state.userEventListStatus) {
                case UserEventListStatus.LOADING:
                  return const Center(child: TumbleLoading());
                case UserEventListStatus.LOADED:
                  return SingleChildScrollView(child: _loaded(context, state));
                case UserEventListStatus.ERROR:
                  return Center(
                    child: Text(
                      S.userEvents.failedToLoad(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 17),
                    ),
                  );
                case UserEventListStatus.INITIAL:
                  return const Center(
                    child: Text(
                      "We couldn't find any upcoming exams",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 17),
                    ),
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
  final userHasNoEvents = state.userEvents!.registeredEvents.isEmpty &&
      state.userEvents!.unregisteredEvents.isEmpty &&
      state.userEvents!.upcomingEvents.isEmpty;

  return userHasNoEvents
      ? Align(
          alignment: Alignment.center,
          child: Text(
            S.userEvents.empty(),
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              letterSpacing: 0.5,
            ),
          ),
        )
      : Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            state.userEvents!.unregisteredEvents.isEmpty
                ? Container()
                : UserEventSection(
                    sectionTitle: S.userEvents.needToSignup(),
                    availableEvents: state.userEvents!.unregisteredEvents,
                    upcomingEvents: null,
                  ),
            state.userEvents!.registeredEvents.isEmpty
                ? Container()
                : UserEventSection(
                    sectionTitle: S.userEvents.alreadySignedUp(),
                    availableEvents: state.userEvents!.registeredEvents,
                    upcomingEvents: null,
                  ),
            state.userEvents!.upcomingEvents.isEmpty
                ? Container()
                : UserEventSection(
                    sectionTitle: S.userEvents.upcoming(),
                    availableEvents: null,
                    upcomingEvents: state.userEvents!.upcomingEvents,
                  )
          ],
        );
}
