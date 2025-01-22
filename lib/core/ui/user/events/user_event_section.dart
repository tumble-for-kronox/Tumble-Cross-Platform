import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/models/backend_models/available_user_event_model.dart';
import 'package:tumble/core/models/backend_models/upcoming_user_event_model.dart';
import 'package:tumble/core/ui/cubit/auth_cubit.dart';
import 'package:tumble/core/ui/user/events/cards/available_user_event_card.dart';
import 'package:tumble/core/ui/user/events/cards/registered_passed_user_event_card.dart';
import 'package:tumble/core/ui/user/events/cards/upcoming_user_event_card.dart';
import 'package:tumble/core/ui/user/events/modals/available_user_event_modal.dart';
import 'package:tumble/core/ui/user/events/modals/registered_passed_user_event_modal.dart';
import 'package:tumble/core/ui/user/events/modals/upcoming_user_event_modal.dart';

class UserEventSection extends StatelessWidget {
  final String sectionTitle;
  final List<AvailableUserEventModel>? availableEvents;
  final List<UpcomingUserEventModel>? upcomingEvents;

  const UserEventSection(
      {super.key, required this.sectionTitle, required this.availableEvents, required this.upcomingEvents});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
        child: Column(
          children: <Widget>[
                _eventsDivider(context, sectionTitle),
              ] +
              (availableEvents == null
                  ? upcomingEvents!
                      .map((e) => UpcomingUserEventCard(
                            userEvent: e,
                            onTap: () {
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) => UpcomingUserEventModal(
                                        userEvent: e,
                                      ));
                            },
                          ))
                      .toList()
                  : availableEvents!.map((e) {
                      return e.lastSignupDate.isBefore(DateTime.now())
                          ? RegisteredPassedUserEventCard(
                              userEvent: e,
                              onTap: () {
                                showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) => RegisteredPassedUserEventModal(userEvent: e));
                              },
                            )
                          : AvailableUserEventCard(
                              userEvent: e,
                              onTap: () {
                                showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) => AvailableUserEventModal(userEvent: e));
                              },
                            );
                    }).toList()),
        ),
      );
    });
  }
}

Widget _eventsDivider(BuildContext context, String title) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.only(right: 12, left: 5),
        child: Text(
          title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.w500,
            fontSize: 16,
            letterSpacing: 0.5,
          ),
        ),
      ),
      Expanded(
        child: Divider(
          color: Theme.of(context).colorScheme.onSurface,
          thickness: 0.1,
        ),
      ),
    ],
  );
}
