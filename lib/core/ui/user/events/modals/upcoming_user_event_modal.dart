import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tumble/core/models/backend_models/upcoming_user_event_model.dart';
import 'package:tumble/core/ui/data/string_constants.dart';
import 'package:tumble/core/ui/app_switch/misc/tumble_details_modal_base.dart';

import '../../../schedule/modal_info_row.dart';

class UpcomingUserEventModal extends StatelessWidget {
  final UpcomingUserEventModel userEvent;

  const UpcomingUserEventModal({super.key, required this.userEvent});

  @override
  Widget build(BuildContext context) {
    return TumbleDetailsModalBase(
      body: Container(
        height: MediaQuery.of(context).size.height - 280,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(right: 0, left: 0, top: 55, bottom: 10),
                child: AutoSizeText(
                  userEvent.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 32, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onSurface),
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
                    title: S.detailsModal.registrationOpens(),
                    icon: const Icon(CupertinoIcons.person_crop_circle_badge_checkmark),
                    subtitle: DateFormat("dd MMMM yyyy", Localizations.localeOf(context).languageCode)
                        .format(userEvent.firstSignupDate),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  ModalInfoRow(
                    title: S.detailsModal.type(),
                    icon: const Icon(CupertinoIcons.square_grid_2x2),
                    subtitle: userEvent.type,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      title: S.detailsModal.title(),
      barColor: Theme.of(context).colorScheme.primary,
    );
  }
}
