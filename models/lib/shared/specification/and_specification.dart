import 'package:models/shared/specification/abstract_specification.dart';

///
/// and_specification.dart
/// bishopric-assistant
///
/// Created by Po on 9/17/21
/// Copyright 2021 Po. All rights reserved.
///

/// [AndSpecification], used to create a new specification that is the AND of two other specifications.
class AndSpecification<T> extends AbstractSpecification<T> {
  Specification<T> _spec1;
  Specification<T> _spec2;

  /// Create a new AND specification based on two other spec.
  ///
  /// [_spec1] Specification one.
  /// [_spec2] Specification two.
  AndSpecification(this._spec1, this._spec2);

  @override
  bool isSatisfiedBy(final T t) {
    return _spec1.isSatisfiedBy(t) && _spec2.isSatisfiedBy(t);
  }
}
