import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/ui/cubit/auth_cubit.dart';
import 'package:tumble/core/ui/cubit/resource_cubit.dart';
import 'package:tumble/core/ui/data/string_constants.dart';
import 'package:tumble/core/ui/scaffold_message.dart';
import 'package:tumble/core/ui/schedule/dynamic_error_page.dart';
import 'package:tumble/core/ui/tumble_loading.dart';
import 'package:tumble/core/ui/user/resources/user_booking.dart';

class UserBookingsContainer extends StatelessWidget {
  const UserBookingsContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      constraints: const BoxConstraints(
        minHeight: 100,
        maxHeight: 500,
        maxWidth: double.maxFinite,
      ),
      child:
          BlocBuilder<ResourceCubit, ResourceState>(builder: (context, state) {
        switch (state.userBookingsStatus) {
          case UserBookingsStatus.loading:
            return Center(
              heightFactor: 0.1,
              child:
                  TumbleLoading(color: Theme.of(context).colorScheme.primary),
            );
          case UserBookingsStatus.loaded:
            return state.userBookings!
                    .where((booking) =>
                        booking.timeSlot.to.isAfter(DateTime.now()))
                    .isEmpty
                ? Center(
                    heightFactor: 0.1,
                    child: Text(S.userBookings.noBookings(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        )),
                  )
                : SizedBox(
                    width: double.maxFinite,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: state.userBookings!
                          .asMap()
                          .entries
                          .where((entry) =>
                              entry.value.timeSlot.to.isAfter(DateTime.now()))
                          .map((entry) => Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 10),
                                child: UserBooking(
                                  onConfirm: () => context
                                      .read<ResourceCubit>()
                                      .confirmBooking(
                                          context
                                              .read<AuthCubit>()
                                              .state
                                              .userSession!,
                                          context
                                              .read<AuthCubit>()
                                              .setUserSession,
                                          context.read<AuthCubit>().logout,
                                          entry.value.resourceId,
                                          entry.value.id,
                                          entry.key)
                                      .then((value) =>
                                          showScaffoldMessage(context, value)),
                                  onUnbook: () => context
                                      .read<ResourceCubit>()
                                      .unbookResource(
                                        context
                                            .read<AuthCubit>()
                                            .state
                                            .userSession!,
                                        context
                                            .read<AuthCubit>()
                                            .setUserSession,
                                        context.read<AuthCubit>().logout,
                                        entry.value.id,
                                        entry.key,
                                      )
                                      .then((value) =>
                                          showScaffoldMessage(context, value)),
                                  booking: entry.value,
                                  confirmLoading:
                                      state.confirmationLoading![entry.key],
                                  unbookLoading:
                                      state.unbookLoading![entry.key],
                                ),
                              ))
                          .toList(),
                    ),
                  );
          case UserBookingsStatus.error:
            return Center(
              heightFactor: 0.1,
              child: Text(
                  context.read<ResourceCubit>().state.userBookingsErrorMessage!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  )),
            );
          case UserBookingsStatus.initial:
            return Container(
              child: Text('This is default'),
            );
        }
      }),
    );
  }
}
