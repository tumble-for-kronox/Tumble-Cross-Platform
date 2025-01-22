import 'package:flutter/material.dart';
import 'package:tumble/core/ui/data/string_constants.dart';
import 'package:tumble/core/ui/app_switch/misc/tumble_details_modal_base.dart';
import 'package:tumble/core/ui/app_switch/misc/tumble_drawer/contributors_modal/contributors_section.dart';

class ContributorsModal extends StatelessWidget {
  const ContributorsModal({super.key});

  @override
  Widget build(BuildContext context) {
    return TumbleDetailsModalBase(
      body: Container(
        height: MediaQuery.of(context).size.height - 260,
        width: double.maxFinite,
        padding: const EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 50),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
          child: Column(
            children: [
              ContributorsSection(
                sessionTitle: S.contributorsModal.development(),
                contributors: const [
                  "Lasse Poulsen",
                  "Adis Veletanlic",
                ],
              ),
              Divider(
                height: 30,
                thickness: 0.2,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              ContributorsSection(
                sessionTitle: S.contributorsModal.design(),
                contributors: const [
                  "Adis Veletanlic",
                  "Lasse Poulsen",
                  "Kia Mian",
                  "Jochem Crab",
                  "Anne-Claire",
                  "Sandra Kaljula",
                ],
              ),
              Divider(
                height: 30,
                thickness: 0.2,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              ContributorsSection(
                sessionTitle: S.contributorsModal.translation(),
                contributors: const [
                  "Tom Welter (German, French)",
                  "Anne-Claire (French)",
                  "Moritz Held (German)",
                  "Tian (Chinese)",
                  "Adis Veletanlic (Swedish)",
                  // "Quang Minh Nguyen (Vietnamese)",
                ],
              ),
              Divider(
                height: 30,
                thickness: 0.2,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              ContributorsSection(
                sessionTitle: S.contributorsModal.specialThanks(),
                contributors: const [
                  "Braco Veletanlic",
                  "Ted Ekström",
                ],
              ),
            ],
          ),
        ),
      ),
      title: S.contributorsModal.title(),
      barColor: Theme.of(context).colorScheme.primary,
    );
  }
}
