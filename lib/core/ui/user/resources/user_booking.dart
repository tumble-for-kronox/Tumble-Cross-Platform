import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tumble/core/models/backend_models/resource_model.dart';
import 'package:tumble/core/ui/cubit/resource_cubit.dart';
import 'package:tumble/core/ui/data/string_constants.dart';
import 'package:tumble/core/ui/tumble_button_small.dart';

class UserBooking extends StatelessWidget {
  final Booking booking;
  final bool confirmLoading;
  final bool unbookLoading;
  final void Function()? onConfirm;
  final void Function()? onUnbook;

  const UserBooking({
    super.key,
    required this.booking,
    required this.confirmLoading,
    required this.unbookLoading,
    required this.onConfirm,
    required this.onUnbook,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.maxFinite,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.surface,
          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 2, offset: Offset(0, 1))]),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.primary,
                  )),
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.only(top: 1),
                child: Text(
                  '${DateFormat.Hm(Localizations.localeOf(context).languageCode).format(booking.timeSlot.from)} - ${DateFormat.Hm(Localizations.localeOf(context).languageCode).format(booking.timeSlot.to)} ${DateFormat('EEE, dd/MM').format(booking.timeSlot.from)}',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.onSecondary,
                    letterSpacing: .5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.userBookings.roomTitle(),
                    style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 12, letterSpacing: 0.5),
                  ),
                  Text(
                    booking.locationId,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  booking.showConfirmButton
                      ? TumbleButtonSmall(
                          onPressed: onConfirm,
                          prefixIcon: CupertinoIcons.check_mark,
                          text: S.general.confirm(),
                          loading: confirmLoading,
                        )
                      : Container(),
                  booking.showUnbookButton
                      ? Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: TumbleButtonSmall(
                            onPressed: onUnbook,
                            prefixIcon: CupertinoIcons.xmark_circle,
                            text: S.userBookings.unbookButton(),
                            loading: unbookLoading,
                          ),
                        )
                      : Container(),
                  context.read<ResourceCubit>().userBookingOngoing(booking) && !booking.showConfirmButton
                      ? Text(
                          S.userBookings.ongoingTitle(),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                          ),
                        )
                      : Container(),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
