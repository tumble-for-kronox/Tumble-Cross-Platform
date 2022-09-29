import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tumble/core/ui/data/string_constants.dart';
import 'package:tumble/core/ui/tumble_loading.dart';
import 'package:tumble/core/ui/user/resources/cubit/resource_cubit.dart';
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
      ),
      child: BlocBuilder<ResourceCubit, ResourceState>(builder: (context, state) {
        switch (state.userBookingsStatus) {
          case UserBookingsStatus.LOADING:
            return Center(
              child: TumbleLoading(color: Theme.of(context).colorScheme.primary),
            );
          case UserBookingsStatus.LOADED:
            return state.userBookings!.isEmpty
                ? Center(
                    child: Text(S.userBookings.noBookings(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontSize: 18,
                            fontWeight: FontWeight.w400)),
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: state.userBookings!
                        .asMap()
                        .entries
                        .map((entry) => UserBooking(
                              booking: entry.value,
                              loading: state.confirmationLoading![entry.key],
                            ))
                        .toList(),
                  );
          case UserBookingsStatus.ERROR:
            return Center(
              child: Text(context.read<ResourceCubit>().state.userBookingsErrorMessage!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground, fontSize: 20, fontWeight: FontWeight.w500)),
            );
          case UserBookingsStatus.INITIAL:
            return Container();
        }
      }),
    );
  }
}
