import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/models/api_models/available_user_event_model.dart';
import 'package:tumble/core/ui/account/user_event_list/user_event_register_button.dart';
import 'package:tumble/core/ui/data/string_constants.dart';

import '../../../login/cubit/auth_cubit.dart';
import '../../../schedule/modal_info_row.dart';
import '../../../schedule/tumble_list_view/tumble_list_view_schedule_card_ribbon.dart';

class RegisteredPassedUserEventModal extends StatelessWidget {
  final AvailableUserEventModel userEvent;

  const RegisteredPassedUserEventModal({Key? key, required this.userEvent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 280,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: MediaQuery.of(context).size.height - 280,
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
                        title: S.detailsModal.type(),
                        icon: const Icon(CupertinoIcons.square_grid_2x2),
                        subtitle: userEvent.type,
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
                    ],
                  )
                ],
              ),
            ),
          ),
          userEvent.supportAvailable
              ? Container(
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.only(right: 15, bottom: 10),
                  child: const UserEventRegisterButton(linkToKronox: true),
                )
              : Container(),
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
