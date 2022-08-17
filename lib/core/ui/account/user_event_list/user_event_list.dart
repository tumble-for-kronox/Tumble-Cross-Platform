import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tumble/core/ui/account/user_event_list/user_event_section.dart';
import 'package:tumble/core/ui/login/cubit/auth_cubit.dart';

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
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Builder(
            builder: (context) {
              switch (state.userEventListStatus) {
                case UserEventListStatus.LOADING:
                  return SpinKitThreeBounce(color: Theme.of(context).colorScheme.primary);
                case UserEventListStatus.LOADED:
                  return _loaded(context, state);
                case UserEventListStatus.ERROR:
                  return Text(
                    "We couldn't get your exams, try again in a bit.",
                    style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
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
      state.userEvents!.unregisteredEvents.isEmpty
          ? Container()
          : UserEventSection(
              sectionTitle: "Need to sign up?",
              availableEvents: state.userEvents!.unregisteredEvents,
              upcomingEvents: null,
            ),
      state.userEvents!.registeredEvents.isEmpty
          ? Container()
          : UserEventSection(
              sectionTitle: "Already signed up",
              availableEvents: state.userEvents!.registeredEvents,
              upcomingEvents: null,
            ),
      state.userEvents!.upcomingEvents.isEmpty
          ? Container()
          : UserEventSection(
              sectionTitle: "Upcoming",
              availableEvents: null,
              upcomingEvents: state.userEvents!.upcomingEvents,
            )
    ],
  );
}
