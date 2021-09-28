///
/// uuid.dart
/// bishopric-assistant
///
/// Created by Po on 9/22/21
/// Copyright 2021 Po. All rights reserved.
///

/// [UUID] forms a unique identity for an object
/// TODO: transform the ID into a string
/// TODO: Comments
abstract class UUID {
  late final String _id;

  UUID(String id) {
    this.__id = id;
  }

  String get id => _id;

  set __id(String id) {
    this._id = id;
  }

  @override
  bool operator ==(Object object) {
    UUID other = object as UUID;
    return this.id == other.id;
  }

// TODO: `create()` method which will create a random unique identifier
}
