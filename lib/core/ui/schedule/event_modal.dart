import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/models/backend_models/schedule_model.dart';
import 'package:tumble/core/ui/cubit/schedule_view_cubit.dart';
import 'package:tumble/core/ui/data/string_constants.dart';
import 'package:tumble/core/ui/app_switch/misc/tumble_details_modal_base.dart';
import 'package:tumble/core/ui/schedule/event_options.dart';
import 'package:tumble/core/ui/schedule/modal_info_row.dart';

class TumbleEventModal extends StatelessWidget {
  final Event event;
  final Color color;
  final bool showSettings;
  const TumbleEventModal(
      {Key? key,
      required this.event,
      required this.color,
      required this.showSettings})
      : super(key: key);

  static void showBookmarkEventModal(
    BuildContext context,
    Event event,
    Color color,
  ) {
    showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: true,
        isDismissible: true,
        context: context,
        builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: BlocProvider.of<ScheduleViewCubit>(context),
                ),
              ],
              child: TumbleEventModal(
                event: event,
                color: event.isSpecial ? Colors.redAccent : color,
                showSettings: true,
              ),
            ));
  }

  static void showPreviewEventModal(
      BuildContext context, Event event, Color color) {
    showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: true,
        isDismissible: true,
        context: context,
        builder: (_) => TumbleEventModal(
              event: event,
              color: color,
              showSettings: false,
            ));
  }

  @override
  Widget build(BuildContext context) {
    final locations = event.locations;
    return TumbleDetailsModalBase(
      body: Container(
        height: MediaQuery.of(context).size.height - 280,
        padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.only(
                    right: 0, left: 0, top: 5, bottom: 10),
                child: AutoSizeText(
                  event.title.capitalize(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
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
                        '${DateFormat.d(Localizations.localeOf(context).languageCode).format(event.from)} ${DateFormat('MMMM', Localizations.localeOf(context).languageCode).format(event.from)} ${DateFormat.y(Localizations.localeOf(context).languageCode).format(event.from)}',
                  ),
                  const SizedBox(height: 25),
                  ModalInfoRow(
                    title: S.detailsModal.time(),
                    icon: const Icon(CupertinoIcons.clock),
                    subtitle:
                        '${DateFormat.Hm(Localizations.localeOf(context).languageCode).format(event.from)} - ${DateFormat.Hm(Localizations.localeOf(context).languageCode).format(event.to)}',
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  ModalInfoRow(
                    title: S.detailsModal.location(),
                    icon: const Icon(CupertinoIcons.location_solid),
                    locations: locations,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  ModalInfoRow(
                    title: S.detailsModal.course(),
                    icon: const Icon(CupertinoIcons.book),
                    subtitle: event.course.englishName,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  ModalInfoRow(
                    title: S.detailsModal.teachers(),
                    icon: const Icon(CupertinoIcons.person_2),
                    teachers: event.teachers,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      title: S.detailsModal.title(),
      barColor: color,
      onSettingsPressed: showSettings
          ? () => EventOptions.showEventOptions(context, event)
          : null,
    );
  }
}
