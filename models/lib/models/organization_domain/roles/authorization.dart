import 'package:models/models/organization.dart';
import 'package:models/shared/domain_driven_design/value_object.dart';
import 'package:models/shared/exceptions/exceptions.dart';

///
/// $FILE_NAME.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 3/18/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class Authorization extends ValueObject<Authorization> {
  static const String nameKey = "Authorization Name";
  static const String rankKey = "Authorization Rank";
  static const String idKey = "Authorization ID";

  late final String _name;
  late final int _rank;
  AuthorizationID? _id;

  Authorization({required String name, required int rank, AuthorizationID? id})
      : this._id = id {
    __name = name;
    __rank = rank;
  }

  Authorization.fromMap(Map<String, dynamic> map)
      : this(
          name: map[nameKey],
          rank: map[rankKey],
          id: map[idKey] == null ? null : AuthorizationID(map[idKey]),
        );

  @override
  bool sameValueAs(Authorization other) {
    return other.rank == this.rank;
  }

  set __name(String name) {
    _name = name;
  }

  set __rank(int rank) {
    if (rank.isNegative)
      throw NegativeIntegerError(forObject: "Authorization Rank");
    _rank = rank;
  }

  @override
  Map<String, dynamic> get toMap => {
        nameKey: name,
        rankKey: rank,
        idKey: _id?.id,
      };

  String get name => _name;

  int get rank => _rank;

  AuthorizationID get id {
    _id ?? (throw IdDoesNotExistError(forObject: "Authorization ID"));
    return _id!;
  }

  @override
  String toString() {
    return "$name: $rank";
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != Authorization) return false;
    return sameValueAs(other as Authorization);
  }

  operator <(Authorization rhs) {
    return this.rank < rhs.rank;
  }

  operator <=(Authorization rhs) {
    return this.rank <= rhs.rank;
  }

  operator >(Authorization rhs) {
    return this.rank > rhs.rank;
  }

  operator >=(Authorization rhs) {
    return this.rank >= rhs.rank;
  }
}
