import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tumble/core/extensions/extensions.dart';
import 'package:tumble/core/models/api_models/schedule_model.dart';
import 'package:tumble/core/ui/data/string_constants.dart';
import 'package:tumble/core/ui/main_app/cubit/main_app_cubit.dart';
import 'package:tumble/core/ui/schedule/event_options.dart';
import 'package:tumble/core/ui/schedule/modal_info_row.dart';
import 'package:tumble/core/ui/search/cubit/search_page_cubit.dart';

class PreviewEventModal extends StatelessWidget {
  final Event event;
  final Color color;
  final SearchPageCubit searchPageCubit;
  const PreviewEventModal({
    Key? key,
    required this.searchPageCubit,
    required this.event,
    required this.color,
  }) : super(key: key);

  static void showPreviewEventModal(BuildContext context, Event event, Color color, SearchPageCubit searchPageCubit) {
    showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: true,
        isDismissible: true,
        context: context,
        builder: (context) => PreviewEventModal(
              event: event,
              color: color,
              searchPageCubit: searchPageCubit,
            ));
  }

  @override
  Widget build(BuildContext context) {
    final locations = event.locations;
    return SizedBox(
      height: MediaQuery.of(context).size.height - 260,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: MediaQuery.of(context).size.height - 260,
            padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 0, left: 0, top: 5, bottom: 10),
                    child: FractionallySizedBox(
                      widthFactor: 0.9,
                      child: Text(
                        event.title,
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
                            '${DateFormat.d().format(event.from)} ${DateFormat('MMMM').format(event.from)} ${DateFormat.y().format(event.from)}',
                      ),
                      const SizedBox(height: 25),
                      ModalInfoRow(
                        title: S.detailsModal.time(),
                        icon: const Icon(CupertinoIcons.clock),
                        subtitle: '${DateFormat.Hm().format(event.from)} - ${DateFormat.Hm().format(event.to)}',
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      ModalInfoRow(
                        title: S.detailsModal.location(),
                        icon: const Icon(CupertinoIcons.location),
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
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              alignment: Alignment.center,
              width: double.maxFinite,
              height: 50,
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Text(
                S.detailsModal.title(),
                style: TextStyle(
                  fontSize: 16,
                  color: color.contrastColor(),
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

class TumbleEventModal extends StatelessWidget {
  final Event event;
  final Color color;
  final MainAppCubit mainAppCubit;
  const TumbleEventModal({
    Key? key,
    required this.event,
    required this.color,
    required this.mainAppCubit,
  }) : super(key: key);

  static void showBookmarkEventModal(BuildContext context, Event event, Color color, MainAppCubit mainAppCubit) {
    showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: true,
        isDismissible: true,
        context: context,
        builder: (context) => TumbleEventModal(
              event: event,
              color: event.isSpecial ? Colors.redAccent : color,
              mainAppCubit: mainAppCubit,
            ));
  }

  @override
  Widget build(BuildContext context) {
    final locations = event.locations;
    return SizedBox(
      height: MediaQuery.of(context).size.height - 260,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: MediaQuery.of(context).size.height - 260,
            padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 0, left: 0, top: 5, bottom: 10),
                    child: FractionallySizedBox(
                      widthFactor: 0.9,
                      child: Text(
                        event.title,
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
                            '${DateFormat.d().format(event.from)} ${DateFormat('MMMM').format(event.from)} ${DateFormat.y().format(event.from)}',
                      ),
                      const SizedBox(height: 25),
                      ModalInfoRow(
                        title: S.detailsModal.time(),
                        icon: const Icon(CupertinoIcons.clock),
                        subtitle: '${DateFormat.Hm().format(event.from)} - ${DateFormat.Hm().format(event.to)}',
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      ModalInfoRow(
                        title: S.detailsModal.location(),
                        icon: const Icon(CupertinoIcons.location),
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
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              alignment: Alignment.center,
              width: double.maxFinite,
              height: 50,
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Text(
                S.detailsModal.title(),
                style: TextStyle(
                  fontSize: 16,
                  color: color.contrastColor(),
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Material(
              color: Colors.transparent,
              child: IconButton(
                splashRadius: 20,
                color: color.contrastColor(),
                onPressed: () => EventOptions.showEventOptions(context, event, mainAppCubit),
                icon: const Icon(CupertinoIcons.ellipsis),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
