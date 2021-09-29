import 'package:flutter/foundation.dart';

import 'serializable.dart';

///
/// value_object.dart
/// bishopric-assistant
///
/// Created by Po on 9/17/21
/// Copyright 2021 Po. All rights reserved.
///

/// A [ValueObject], as described in the DDD book.
abstract class ValueObject<T> extends Serializable {
  @required
  ValueObject.decode(Map<String, dynamic> json) : super.decode(json);

  /// Value objects compare by the values of their attributes, they don't have an identity.
  ///
  /// The [other] value object.
  /// Returns `true` if the given value object's and this value object's
  /// attributes are the same.
  @required
  bool sameValueAs(T other);
}
