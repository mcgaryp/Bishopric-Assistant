///
/// for_object_exception.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 10/28/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class ForObjectException implements Exception {
  final String msg;
  final String? forObject;

  ForObjectException(this.msg, {this.forObject});

  @override
  String toString() {
    if (forObject == null) return msg;
    return "$msg for object $forObject";
  }
}
