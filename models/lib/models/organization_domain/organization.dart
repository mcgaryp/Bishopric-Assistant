import 'package:models/shared/entity.dart';
import 'package:models/util/extensions/string_extensions.dart';

import '../member.dart';
import '../organization.dart';
import '../role.dart';
import '../user.dart';

///
/// organization.dart
/// bishopric-assistant
///
/// Created by Po on 9/22/21
/// Copyright 2021 Po. All rights reserved.
///

// TODO: Remove late somehow
class Organization extends Entity<Organization> {
  /// Variables
  ///
  /// [id] of the organization
  final OrganizationID id;

  /// [_creator] the initial member and user of the organization
  late Member _creator;

  /// [_name] the name of the organization
  late String _name;

  /// Constructor
  ///
  /// [id] of the organization
  /// [name] of the organization
  /// [creator] of the organization
  Organization({required this.id, required String name, required User creator})
      : super(id) {
    __name = name;
    __creator = creator;
  }

  Organization.newName(Organization organization, this._name)
      : this.id = organization.id,
        this._creator = organization.creator,
        super(organization.id);

  /// Setters
  ///
  /// [__name] private setter for name
  set __name(String name) => _name = name.checkCapitalization;

  /// [__creator] private setter for the creator and initial member in the organization
  set __creator(User user) {
    _creator = Member(user: user, role: Role.creator(), organizationID: id);
  }

  /// Getters
  String get name => _name;

  Member get creator => _creator;

  @override
  bool sameIdentityAs(Organization other) {
    return this.id == other.id;
  }
}
