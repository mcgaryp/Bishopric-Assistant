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
  /// Json Keys
  static const String nameKey = "Organization Name";
  static const String creatorKey = "Organization Creator";
  static const String idKey = "Organization ID";

  /// Variables
  ///
  /// [id] of the organization
  final OrganizationID? _id;

  /// [_creator] the initial member and user of the organization
  final Member creator;

  /// [_name] the name of the organization
  late String _name;

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

  /// Convert Organization from Json
  ///
  /// [map] mapped json
  Organization.fromMap(Map<String, dynamic> map)
      : this(
            id: map[idKey] == null ? null : OrganizationID(map[idKey]),
            name: map[nameKey],
            creator: Member.fromMap(map[creatorKey]));

  /// Setters
  ///
  /// [__name] private setter for name
  set name(String name) => _name = name.capitalize;

  @override
  Map<String, dynamic> get toMap =>
      {creatorKey: creator.toMap, nameKey: name, idKey: _id?.id};

  /// Get an ID without running into a null value
  OrganizationID get id {
    if (_id == null) throw IdDoesNotExistError(forObject: "Organization");
    return _id!;
  }

  /// Get the [name] of the organization
  String get name => _name;

  /// Who can add and remove members from the organization?
  bool canAddRemove({Authorization? authorization, MemberID? id}) {
    // The creator
    if (id != null && id == creator.id) return true;
    // TODO: This should be based off the Organization Settings
    if (authorization != null && authorization.rank >= 1)
      return true;
    return false;
  }

  /// Who can edit member roles in the organization?
  bool canEditRoles({Authorization? authorization, MemberID? id}) {
    return canAddRemove(authorization: authorization, id: id);
  }

  /// Who can edit the organizations name and general specifics
  bool canEdit({Authorization? authorization, MemberID? id}) {
    // TODO: This should be based off the Organization Settings
    return (creator.id == id || (authorization != null && authorization.rank == 0));
  }

  @override
  bool sameIdentityAs(Organization other) {
    return this._id == other._id &&
        this.name == other.name &&
        this.creator == other.creator;
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != Organization) return false;
    return sameIdentityAs(other as Organization);
  }

  @override
  String toString() {
    return "Name: $name\nCreator: $creator\nID: ${_id?.id}";
  }
}
