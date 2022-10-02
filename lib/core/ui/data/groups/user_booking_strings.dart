import 'package:flutter/material.dart';
import 'package:tumble/core/ui/data/string_constant_group.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserBookingStrings extends StringConstantGroup {
  UserBookingStrings(AppLocalizations localizedStrings) : super(localizedStrings);

  String noBookings() => localizedStrings.userBookingsNoBookings;
  String noAvailableTimeSlots() => localizedStrings.userBookingsNoAvailableTimeSlots;
}
