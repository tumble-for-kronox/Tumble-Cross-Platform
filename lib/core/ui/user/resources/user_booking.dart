import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tumble/core/models/api_models/resource_model.dart';
import 'package:tumble/core/ui/login/cubit/auth_cubit.dart';
import 'package:tumble/core/ui/tumble_button.dart';
import 'package:tumble/core/ui/user/resources/cubit/resource_cubit.dart';

class UserBooking extends StatelessWidget {
  final Booking booking;
  final bool loading;

  const UserBooking({Key? key, required this.booking, required this.loading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.loose,
      child: Container(
        constraints: const BoxConstraints(maxHeight: 140),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.surface,
            boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 2, offset: Offset(0, 1))]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
                    '${DateFormat.Hm(Localizations.localeOf(context).languageCode).format(booking.timeSlot.from)} - ${DateFormat.Hm(Localizations.localeOf(context).languageCode).format(booking.timeSlot.to)}',
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
            Expanded(
              child: Row(
                children: [
                  () {
                    if (booking.getConfirmationOpens != null && booking.getConfirmationCloses != null) {
                      if (DateTime.now().isAfter(booking.getConfirmationOpens!) &&
                          DateTime.now().isBefore(booking.getConfirmationCloses!)) {
                        return TumbleButton(
                            onPressed: () {}, prefixIcon: CupertinoIcons.check_mark, text: "Confirm", loading: loading);
                      }
                    }
                    return Container();
                  }(),
                  () {
                    if (DateTime.now().isBefore(booking.timeSlot.from)) {
                      return TumbleButton(
                          onPressed: () => context
                              .read<ResourceCubit>()
                              .unbookResource(BlocProvider.of<AuthCubit>(context), booking.id),
                          prefixIcon: CupertinoIcons.xmark,
                          text: "Unbook",
                          loading: context.read<ResourceCubit>().state.bookUnbookStatus == BookUnbookStatus.LOADING);
                    }

                    return Container();
                  }()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
