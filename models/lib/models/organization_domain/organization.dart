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
  final OrganizationID id;

  /// [_creator] the initial member and user of the organization
  final Member creator;

  /// [_name] the name of the organization
  late final String _name;

  /// Constructor
  ///
  /// [id] of the organization
  /// [name] of the organization
  /// [creator] of the organization
  Organization({required this.id, required String name, required this.creator})
      : super(id) {
    __name = name;
  }

  /// Copy constructor to create a new name
  Organization.newName(Organization organization, this._name)
      : this.id = organization.id,
        this.creator = organization.creator,
        super(organization.id);

  /// Setters
  ///
  /// [__name] private setter for name
  set __name(String name) => _name = name.capitalize;

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
}
