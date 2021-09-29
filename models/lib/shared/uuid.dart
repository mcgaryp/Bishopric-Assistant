import 'package:models/shared/exceptions.dart';
import 'package:models/shared/value_object.dart';

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
abstract class UUID extends ValueObject<UUID> {
  late final String _id;

  UUID(String id) : super.decode({"id": id}) {
    this.__id = id;
  }

  String get id => _id;

  set __id(String id) {
    if (id.isEmpty) throw EmptyStringError();
    this._id = id;
  }

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
      };

  @override
  bool operator ==(Object object) {
    UUID other = object as UUID;
    return this.id == other.id;
  }

// TODO: `create()` method which will create a random unique identifier
}
