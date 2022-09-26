import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tumble/core/models/api_models/resource_model.dart';
import 'package:tumble/core/ui/schedule/tumble_list_view/data/custom_alerts.dart';
import 'package:tumble/core/ui/tumble_loading.dart';
import 'package:tumble/core/ui/user/cubit/user_event_cubit.dart';
import 'package:tumble/core/ui/user/resources/confirm_booking.dart';
import 'package:tumble/core/ui/user/resources/location_card_containers.dart';
import 'package:tumble/core/ui/user/resources/resource_room_card.dart';
import 'package:tumble/core/ui/user/resources/time_stamp_containers.dart';
import 'package:tumble/core/ui/user/resources/resource_time_stamp_card.dart';

import '../../login/cubit/auth_cubit.dart';
import 'cubit/resource_cubit.dart';

class TumbleChosenResourcePage extends StatelessWidget {
  const TumbleChosenResourcePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResourceCubit, ResourceState>(
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: Container(
            color: Theme.of(context).colorScheme.primary,
            child: Column(
              children: [
                Expanded(flex: 1, child: _upperSection(context, state)),
                Expanded(
                  flex: 4,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      color: Theme.of(context).colorScheme.background,
                    ),
                    child: _lowerSection(context, state),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _upperSection(BuildContext context, ResourceState state) {
    switch (state.status) {
      case ResourceStatus.LOADING:
        return Container();
      case ResourceStatus.LOADED:
      case ResourceStatus.ERROR:
      case ResourceStatus.INITIAL:
        return _upperSectionLoaded(context, state);
    }
  }

  Widget _lowerSection(BuildContext context, ResourceState state) {
    switch (state.status) {
      case ResourceStatus.LOADING:
        return const TumbleLoading();
      case ResourceStatus.LOADED:
        return _lowerSectionLoaded(context, state);
      case ResourceStatus.ERROR:
      case ResourceStatus.INITIAL:
        return _lowerSectionError(context, state);
    }
  }

  Widget _upperSectionLoaded(BuildContext context, ResourceState state) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 10, top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                state.currentLoadedResource!.name,
                style: TextStyle(
                  fontSize: 18,
                  letterSpacing: 1,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              Text(
                DateFormat("MMMM d, y").format(context.read<ResourceCubit>().state.chosenDate),
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(
                CupertinoIcons.calendar,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              onPressed: () async {
                await context.read<ResourceCubit>().userUpdateActiveDate(context).then((value) {
                  if (value == null) return;
                  context
                      .read<ResourceCubit>()
                      .getResourceAvailabilities(context.read<AuthCubit>(), state.currentLoadedResource!.id, value);
                });
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _lowerSectionError(BuildContext context, ResourceState state) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(context.read<ResourceCubit>().state.resourcePageErrorMessage!,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground, fontSize: 20, fontWeight: FontWeight.w500)),
        Padding(
          padding: const EdgeInsets.only(top: 0, left: 3),
          child: IconButton(
              iconSize: 20,
              color: Theme.of(context).colorScheme.primary,
              onPressed: () => showCupertinoDialog(
                  context: context,
                  builder: (context) {
                    return CustomAlertDialog.resourceNotGettable(context);
                  }),
              icon: const Icon(CupertinoIcons.info_circle)),
        )
      ],
    ));
  }

  Widget _lowerSectionLoaded(BuildContext context, ResourceState state) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TimeStampContainer(
            cards: (state.availableTimeSlots!
                  ..sort(
                    (a, b) => a.from.isAfter(b.from) ? 1 : 0,
                  ))
                .map((e) => TimeStampCard(timeSlot: e, selectedTimeSlot: state.selectedTimeSlot))
                .toList(),
            maxRowItems: 3,
          ),
          state.selectedTimeSlot == null
              ? Container()
              : LocationCardContainer(
                  key: Key(state.selectedTimeSlot.toString()),
                  cards: state.availableLocationsForTimeSlots![state.selectedTimeSlot!.id]!
                      .map((e) => RoomCard(
                            roomId: e,
                            selectedRoomId: state.selectedLocationId,
                          ))
                      .toList(),
                  maxRowItems: 4,
                ),
          BlocBuilder<ResourceCubit, ResourceState>(
            builder: (context, nestState) => nestState.selectedLocationId == null || nestState.selectedTimeSlot == null
                ? Container()
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                    child: ConfirmBooking(
                      state: nestState,
                    )),
          )
        ],
      ),
    );
  }
}
