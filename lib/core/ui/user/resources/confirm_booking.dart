import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tumble/core/ui/login/cubit/auth_cubit.dart';
import 'package:tumble/core/ui/scaffold_message.dart';
import 'package:tumble/core/ui/tumble_button.dart';

import 'cubit/resource_cubit.dart';

class ConfirmBooking extends StatelessWidget {
  final ResourceState state;

  const ConfirmBooking({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Divider(
          thickness: 0.5,
          color: Theme.of(context).colorScheme.onBackground,
        ),
        Flexible(
          fit: FlexFit.loose,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Room: ${state.selectedLocationId}"),
                    Text(
                        "Time:  ${DateFormat.Hm().format(state.selectedTimeSlot!.from)} - ${DateFormat.Hm().format(state.selectedTimeSlot!.to)}"),
                  ],
                ),
              ),
              Expanded(
                child: TumbleButton(
                  onPressed: () => state.bookUnbookStatus == BookUnbookStatus.LOADING
                      ? null
                      : context
                          .read<ResourceCubit>()
                          .bookResource(
                              context.read<AuthCubit>(),
                              state.currentLoadedResource!.id,
                              state.chosenDate,
                              state.currentLoadedResource!
                                  .availabilities![state.selectedLocationId!]![state.selectedTimeSlot!.id]!)
                          .then((value) => showScaffoldMessage(context, value)),
                  prefixIcon: CupertinoIcons.check_mark,
                  text: "Confirm",
                  loading: state.bookUnbookStatus == BookUnbookStatus.LOADING,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
