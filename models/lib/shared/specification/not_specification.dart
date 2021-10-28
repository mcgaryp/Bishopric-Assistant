import 'package:models/shared/specification/abstract_specification.dart';

///
/// not_specification.dart
/// bishopric-assistant
///
/// Created by Po on 9/17/21
/// Copyright 2021 Po. All rights reserved.
///

/// [NotSpecification], used to create a new specification that is the inverse (NOT) of the given spec.
class NotSpecification<T> extends AbstractSpecification<T> {
  Specification<T> _spec1;

  /// Create a new [NotSpecification] based on another spec.
  ///
  /// [_spec1] Specification instance to not.
  NotSpecification(this._spec1);

  @override
  bool isSatisfiedBy(final T t) {
    return !_spec1.isSatisfiedBy(t);
  }
}
