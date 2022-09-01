import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/models/api_models/available_user_event_model.dart';
import 'package:tumble/core/ui/account/user_event_list/user_event_register_button.dart';
import 'package:tumble/core/ui/account/user_event_list/user_event_unregister_button.dart';
import 'package:tumble/core/ui/data/string_constants.dart';
import 'package:tumble/core/ui/login/cubit/auth_cubit.dart';

import '../../../../navigation/app_navigator.dart';
import '../../../schedule/modal_info_row.dart';
import '../../../schedule/tumble_list_view/tumble_list_view_schedule_card_ribbon.dart';

class AvailableUserEventModal extends StatelessWidget {
  final AvailableUserEventModel userEvent;

  const AvailableUserEventModal({Key? key, required this.userEvent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 240,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: MediaQuery.of(context).size.height - 240,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(right: 0, left: 0, top: 55, bottom: 10),
                    child: Text(
                      userEvent.title.length < 40
                          ? userEvent.title.capitalize()
                          : '${userEvent.title.substring(0, 40).capitalize()}..',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 32, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onBackground),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ModalInfoRow(
                        title: S.detailsModal.date(),
                        icon: const Icon(CupertinoIcons.calendar),
                        subtitle:
                            '${DateFormat.d(Localizations.localeOf(context).languageCode).format(userEvent.eventStart)} ${DateFormat('MMMM', Localizations.localeOf(context).languageCode).format(userEvent.eventStart)} ${DateFormat.y(Localizations.localeOf(context).languageCode).format(userEvent.eventStart)}',
                      ),
                      const SizedBox(height: 25),
                      ModalInfoRow(
                        title: S.detailsModal.time(),
                        icon: const Icon(CupertinoIcons.clock),
                        subtitle:
                            '${DateFormat.Hm(Localizations.localeOf(context).languageCode).format(userEvent.eventStart)} - ${DateFormat.Hm(Localizations.localeOf(context).languageCode).format(userEvent.eventEnd)}',
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      ModalInfoRow(
                        title: S.detailsModal.registerBefore(),
                        icon: const Icon(CupertinoIcons.person_crop_circle_badge_checkmark),
                        subtitle: DateFormat("dd MMMM yyyy", Localizations.localeOf(context).languageCode)
                            .format(userEvent.lastSignupDate),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      ModalInfoRow(
                        title: S.detailsModal.type(),
                        icon: const Icon(CupertinoIcons.square_grid_2x2),
                        subtitle: userEvent.type,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      ModalInfoRow(
                        title: S.detailsModal.support(),
                        icon: const Icon(CupertinoIcons.question_circle),
                        subtitle: userEvent.supportAvailable
                            ? S.detailsModal.supportAvailable()
                            : S.detailsModal.supportUnavailable(),
                      ),
                      () {
                        return userEvent.anonymousCode.isEmpty
                            ? Container()
                            : const SizedBox(
                                height: 25,
                              );
                      }(),
                      () {
                        return userEvent.anonymousCode.isEmpty
                            ? Container()
                            : ModalInfoRow(
                                title: S.detailsModal.anonymousCode(),
                                icon: const Icon(CupertinoIcons.lock),
                                subtitle: userEvent.anonymousCode,
                              );
                      }(),
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            padding: const EdgeInsets.only(right: 15, bottom: 10),
            child: userEvent.isRegistered
                ? UserEventUnregisterButton(onPressed: () {
                    BlocProvider.of<AuthCubit>(context).unregisterUserEvent(userEvent.id);
                    Navigator.pop(context);
                  })
                : UserEventRegisterButton(
                    linkToKronox: userEvent.requiresChoosingLocation,
                    onPressed: userEvent.requiresChoosingLocation
                        ? null
                        : () {
                            BlocProvider.of<AuthCubit>(context).registerUserEvent(userEvent.id);
                            Navigator.pop(context);
                          }),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              alignment: Alignment.center,
              width: double.maxFinite,
              height: 50,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Text(
                S.detailsModal.title(),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
