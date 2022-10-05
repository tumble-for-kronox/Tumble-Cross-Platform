import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tumble/core/models/api_models/resource_model.dart';
import 'package:tumble/core/ui/user/resources/cubit/resource_cubit.dart';

class TimeStampCard extends StatelessWidget {
  final TimeSlot timeSlot;
  final TimeSlot? selectedTimeSlot;

  const TimeStampCard({Key? key, required this.timeSlot, required this.selectedTimeSlot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 2, offset: Offset(0, 1))],
          ),
          child: MaterialButton(
            padding: EdgeInsets.zero,
            onPressed: () => context.read<ResourceCubit>().changeSelectedTimeStamp(timeSlot),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Text(
              "${DateFormat.Hm().format(timeSlot.from)} - ${DateFormat.Hm().format(timeSlot.to)}",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        selectedTimeSlot?.id == timeSlot.id
            ? Container(
                height: 10,
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                  color: Theme.of(context).colorScheme.primary,
                ),
              )
            : Container(),
      ],
    );
  }
}
