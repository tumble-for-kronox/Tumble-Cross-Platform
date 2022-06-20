// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/foundation.dart';

@immutable
class AppException implements Exception {
  final _message;
  final _prefix;

  const AppException([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  const FetchDataException([String? message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  const BadRequestException([message]) : super(message, "Invalid Request: ");
}

class InvalidInputException extends AppException {
  const InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}
