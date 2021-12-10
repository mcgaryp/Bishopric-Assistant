import 'package:flutter/foundation.dart';

import '../uuid.dart';

export '../uuid.dart';

///
/// entity.dart
/// bishopric-assistant
///
/// Created by Po on 9/17/21
/// Copyright 2021 Po. All rights reserved.
///

/// An [Entity], as explained in the DDD book.
abstract class Entity<T> {
  final UUID id;
  Entity(this.id);

  /// Entities compare by identity, not by attributes.
  ///
  /// The [other] entity.
  /// Returns `true` if the identities are the same, regardless of other attributes.
  @required
  bool sameIdentityAs(T other);

  @required
  bool operator ==(Object other);

  @required
  Map<String, dynamic> get toMap;
}
