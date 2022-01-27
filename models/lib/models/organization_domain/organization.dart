import 'package:models/models/organization.dart';
import 'package:models/shared/foundation.dart';

///
/// organization.dart
/// bishopric-assistant
///
/// Created by Po on 9/22/21
/// Copyright 2021 Po. All rights reserved.
///

/// [Organization] is the entity that groups members together.
class Organization extends Entity<Organization> {
  /// Variables
  ///
  /// [id] of the organization
  late final OrganizationID? _id;

  /// [_creator] the initial member and user of the organization
  final Member creator;

  /// [_name] the name of the organization
  late final String _name;

  static const String nameKey = "Organization Name";
  static const String creatorKey = "Organization Creator";
  static const String idKey = "Organization ID";

  /// Constructor
  ///
  /// [id] of the organization
  /// [name] of the organization
  /// [creator] of the organization
  Organization(
      {OrganizationID? id, required String name, required this.creator})
      : this._id = id,
        super(id) {
    this.name = name;
  }

  Organization.fromMap(Map<String, dynamic> map)
      : this(
            id: OrganizationID(map[idKey]),
            name: map[nameKey],
            creator: Member.fromMap(map[creatorKey]));

  @override
  Map<String, dynamic> get toMap =>
      {creatorKey: creator.toMap, nameKey: name, idKey: _id?.id};

  /// Setters
  ///
  /// [__name] private setter for name
  set name(String name) => _name = name.capitalize;

  OrganizationID get id {
    if (_id == null) throw IdDoesNotExistError(forObject: "Organization");
    return _id!;
  }

  /// Getters
  String get name => _name;

  @override
  bool sameIdentityAs(Organization other) {
    return this.id == other.id;
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != Organization) return false;
    return sameIdentityAs(other as Organization);
  }

  @override
  String toString() {
    return "Name: $name\nCreator: $creator";
  }
}
