///
/// failed_to_remove_error.dart
/// bishopric-assistant
///
/// Created by Po on 10/3/21
/// Copyright 2021 Po. All rights reserved.
///

class FailedToRemoveError implements Exception {
  final String msg = "Failed to remove";
  late final String? _forEntity;

  FailedToRemoveError({String? forEntity}) {
    _forEntity = forEntity;
  }

  @override
  String toString() {
    if (_forEntity != null) return "$msg the entity $_forEntity";
    return msg;
  }
}
