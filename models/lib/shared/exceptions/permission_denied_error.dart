///
/// permission_denied_error.dart
/// bishopric-assistant
///
/// Created by Po on 9/29/21
/// Copyright 2021 Po. All rights reserved.
///

class PermissionDeniedError implements Exception {
  final String msg = "Permission Denied";
  final String reason;

  PermissionDeniedError({this.reason = ""});

  @override
  String toString() {
    return "$msg: $reason";
  }
}
