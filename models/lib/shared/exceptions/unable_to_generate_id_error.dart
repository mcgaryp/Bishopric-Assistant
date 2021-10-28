///
/// unable_to_generate_id_error.dart
/// bishopric-assistant
///
/// Created by Po on 9/29/21
/// Copyright 2021 Po. All rights reserved.
///

class UnableToGenerateIdError implements Exception {
  final String msg = "Unable to generate next ID";
  final String forEntity;

  UnableToGenerateIdError({this.forEntity = ""});

  @override
  String toString() {
    return "$msg for $forEntity";
  }
}
