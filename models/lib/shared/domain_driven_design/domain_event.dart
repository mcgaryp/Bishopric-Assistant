import 'package:flutter/foundation.dart';

///
/// domain_event.dart
/// bishopric-assistant
///
/// Created by Po on 9/17/21
/// Copyright 2021 Po. All rights reserved.
///

/// A [DomainEvent] is something that is unique, but does not have a lifecycle.
///
/// The identity may be explicit, for example the sequence number of a payment,
/// or it could be derived from various aspects of the event such as where,
/// when and what has happened.
abstract class DomainEvent<T> {
  /// The [other] domain event.
  ///
  /// Returns `true` if the given domain event and this event are regarded as
  /// being the same event.
  @required
  bool sameEventAs(T other);
}
