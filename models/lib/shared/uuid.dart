import 'exceptions/negative_integer_error.dart';

///
/// uuid.dart
/// bishopric-assistant
///
/// Created by Po on 9/22/21
/// Copyright 2021 Po. All rights reserved.
///

/// [UUID] forms a unique identity for an object
/// TODO: transform the ID into a string
abstract class UUID {
  late final int _id;

  UUID(int id) {
    this.__id = id;
  }

  int get id => _id;

  set __id(int id) {
    if (id < 0) throw NegativeIntegerError();
    this._id = id;
  }

  // TODO: `create()` method which will create a random unique identifier
}
