///
/// failed_to_save_error.dart
/// bishopric-assistant
///
/// Created by Po on 10/3/21
/// Copyright 2021 Po. All rights reserved.
///

class FailedToSaveError implements Exception {
  final String msg = "Failed to save";
  late final String? _forEntity;

  FailedToSaveError({String? forEntity}) {
    _forEntity = forEntity;
  }

  @override
  String toString() {
    if (_forEntity != null) return "$msg the entity $_forEntity";
    return msg;
  }
}
