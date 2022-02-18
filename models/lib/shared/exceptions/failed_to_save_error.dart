///
/// failed_to_save_error.dart
/// bishopric-assistant
///
/// Created by Po on 10/3/21
/// Copyright 2021 Po. All rights reserved.
///

class FailedToSaveError implements Exception {
  final String msg = "Failed to save";
  final String? _reason;

  FailedToSaveError({String? reason}) : _reason = reason;

  @override
  String toString() {
    if (_reason != null) return "$msg: $_reason";
    return msg;
  }
}
