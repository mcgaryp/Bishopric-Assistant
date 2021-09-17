import 'package:flutter/foundation.dart';

export 'and_specification.dart';
export 'not_specification.dart';
export 'or_specification.dart';

///
/// specification.dart
/// bishopric-assistant
///
/// Created by Po on 9/17/21
/// Copyright 2021 Po. All rights reserved.
///

/// [Specification] interface.
///
/// Use [AbstractSpecification] as base for creating specifications, and
/// only the method `isSatisfiedBy(Object)` must be implemented.
mixin Specification<T> {
  ///Check if {@code t} is satisfied by the specification.
  ///
  /// [t] is the Object to test.
  /// Returns `true` if [t] satisfies the specification.
  @required
  bool isSatisfiedBy(T t);

  /// Create a new specification that is the AND operation of `this specification and another specification.
  ///
  /// [specification] Specification to AND.
  /// Returns A new specification.
  @required
  Specification<T> and(Specification<T> specification);

  /// Create a new specification that is the OR operation of `this` specification and another specification.
  ///
  /// [specification] Specification to OR.
  /// Returns A new specification.
  @required
  Specification<T> or(Specification<T> specification);

  /// Create a new specification that is the NOT operation of `this` specification.
  ///
  /// [specification] Specification to NOT.
  /// Returns A new specification.
  @required
  Specification<T> not(Specification<T> specification);
}
