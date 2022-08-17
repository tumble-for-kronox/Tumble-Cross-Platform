import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/models/api_models/available_user_event_model.dart';
import 'package:tumble/core/models/api_models/upcoming_user_event_model.dart';
import 'package:tumble/core/ui/account/user_event_list/available_event_card.dart';
import 'package:tumble/core/ui/account/user_event_list/registered_passed_event_card.dart';
import 'package:tumble/core/ui/account/user_event_list/upcoming_event_card.dart';

import '../../login/cubit/auth_cubit.dart';

class UserEventSection extends StatelessWidget {
  final String sectionTitle;
  final List<AvailableUserEventModel>? availableEvents;
  final List<UpcomingUserEventModel>? upcomingEvents;

  const UserEventSection(
      {Key? key, required this.sectionTitle, required this.availableEvents, required this.upcomingEvents})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
        child: Column(
          children: <Widget>[
                _eventsDivider(context, state, sectionTitle),
              ] +
              (availableEvents == null
                  ? <Widget>[Container()]
                  : availableEvents!.map((e) {
                      return e.lastSignupDate.isBefore(DateTime.now())
                          ? RegisteredPassedEventCards(event: e)
                          : AvailableEventCard(event: e);
                    }).toList()) +
              (upcomingEvents == null
                  ? <Widget>[Container()]
                  : upcomingEvents!.map((e) => UpcomingEventCard(event: e)).toList()),
        ),
      );
    });
  }
}

Widget _eventsDivider(BuildContext context, AuthState state, String title) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.only(right: 12),
        child: Text(
          title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
            fontWeight: FontWeight.w500,
            fontSize: 16,
            letterSpacing: 0.5,
          ),
        ),
      ),
      Expanded(
        child: Divider(
          color: Theme.of(context).colorScheme.onBackground,
          thickness: 1,
        ),
      ),
    ],
  );
}
