import 'package:flutter/material.dart';
import 'package:models/models/organization_domain/organization_id.dart';
import 'package:models/shared/entity.dart';
import 'package:models/util/extensions/string_extensions.dart';

import 'member.dart';
import 'member_id.dart';
import 'role.dart';
import 'user.dart';

///
/// organization.dart
/// bishopric-assistant
///
/// Created by Po on 9/22/21
/// Copyright 2021 Po. All rights reserved.
///

// TODO: Remove late somehow
abstract class Organization extends Entity<Organization> {
  /// Variables
  ///
  /// [id] of the organization
  final OrganizationID id;

  /// [_creator] the initial member and user of the organization
  late User _creator;

  /// [_name] the name of the organization
  late String _name;

  /// [_members] that are in the organization
  late List<Member> _members;

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

  /// Setters
  ///
  /// [__name] private setter for name
  set __name(String name) => _name = name.checkCapitalization;

  /// [__creator] private setter for the creator and initial member in the organization
  set __creator(User user) {
    _creator = user;
    Member member =
        Member(user: creator, role: Role.creator, organizationID: id);
    _members = [member];
  }

  /// Getters
  String get name => _name;
  User get creator => _creator;
  List<Member> get members => _members;

  @override
  bool sameIdentityAs(Organization other) {
    return this.id == other.id;
  }

  /// Adds a member to the organization
  ///
  /// [memberID] id of the member being added to the organization
  /// Returns a boolean of `true` if the removal was successful
  @required
  bool addMember(MemberID memberID);

  /// Removes a member from the organization
  ///
  /// [memberID] id of the member being removed from the organization
  /// Returns a boolean of `true` if the removal was successful
  @required
  bool removeMember(MemberID memberID);

  /// Changes the role of a member in the organization
  ///
  /// [memberID] member whose role is changing
  /// [accessMemberID] member who is changing the [memberID] role
  /// [newRole] the new role of the [memberID]
  /// Returns a boolean of `true` if the removal was successful
  @required
  bool changeMemberRole(
      MemberID memberID, MemberID accessMemberID, Role newRole);

  /// Finds a member in the organization by memberID
  ///
  /// [memberID] the member that is being searched for in the organization
  /// Returns [Member] that was searched for
  @required
  Member findMember(MemberID memberID);

  /// Changes the name of the organization
  ///
  /// [accessMemberID] id of the member who is editing the name of the organization
  /// [newName] is the string that will represent the new organization name
  @required
  void editName(MemberID accessMemberID, String newName);
}
