import 'package:models/shared/domain_driven_design/value_object.dart';
import 'package:models/shared/exceptions/exceptions.dart';

///
/// uuid.dart
/// bishopric-assistant
///
/// Created by Po on 9/22/21
/// Copyright 2021 Po. All rights reserved.
///

/// [UUID] forms a unique identity for an object
abstract class UUID extends ValueObject<UUID> {
  late final String _id;

  UUID(String id) {
    this.__id = id;
  }

  String get id => _id;

  set __id(String id) {
    if (id.isEmpty) throw EmptyStringError(forObject: "UUID");
    this._id = id;
  }

  @override
  Map<String, dynamic> get toMap => {
        "id": id,
      };

  @override
  bool operator ==(Object object) {
    UUID other = object as UUID;
    return this.id == other.id;
  }

  @override
  bool sameValueAs(UUID other) {
    return this.id == other.id;
  }

  @override
  String toString() {
    return _id;
  }
}
