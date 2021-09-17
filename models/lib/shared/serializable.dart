import 'dart:convert';

import 'package:flutter/foundation.dart';

///
/// serializable.dart
/// bishopric-assistant
///
/// Created by Po on 9/17/21
/// Copyright 2021 Po. All rights reserved.
///

/// [Serializable] converts back and forth from JSON
abstract class Serializable {
  /// Returns a [Serializable] Object from json Map Object
  ///
  /// Use `jsonDecode()` from `dart:convert` to decode the JSON string as the
  /// method argument to convert the String into a Map
  @required
  Serializable.decode(Map<String, dynamic> json);

  /// Returns Map of the object in JSON format
  @required
  Map<String, dynamic> toJson();

  /// Returns the Object as a JSON String
  String encode() => jsonEncode(this);
}
