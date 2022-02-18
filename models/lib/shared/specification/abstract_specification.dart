import 'package:models/shared/specification/specification_mixin.dart';

export 'specification_mixin.dart';

///
/// abstract_specification.dart
/// bishopric-assistant
///
/// Created by Po on 9/17/21
/// Copyright 2021 Po. All rights reserved.
///

/// Abstract base implementation of composite [Specification] with default implementations for `and`, `or` and `not`.
abstract class AbstractSpecification<T> implements Specification<T> {
  @override
  Specification<T> and(final Specification<T> specification) {
    return AndSpecification<T>(this, specification);
  }

  @override
  Specification<T> or(final Specification<T> specification) {
    return OrSpecification<T>(this, specification);
  }

  @override
  Specification<T> not(final Specification<T> specification) {
    return NotSpecification<T>(specification);
  }
}
