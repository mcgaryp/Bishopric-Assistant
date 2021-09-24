import 'package:async/async.dart';
import 'package:flutter/foundation.dart';
import 'package:models/models/member.dart';
import 'package:models/models/organization.dart';
import 'package:models/models/role.dart';
import 'package:models/models/user.dart';

///
/// add_member_to_organization.dart
/// bishopric-assistant
///
/// Created by Po on 9/23/21
/// Copyright 2021 Po. All rights reserved.
///

mixin AddMemberToOrganizationUseCase {
  @required
  Future<Result> execute(UserID userID, RoleID roleID,
      OrganizationID organizationID);
}

class DefaultAddMemberToOrganizationUseCase
    implements AddMemberToOrganizationUseCase {

  UserRepository _userRepository;
  RoleRepository _roleRepository;
  MemberRepository _memberRepository;

  DefaultAddMemberToOrganizationUseCase(this._userRepository,
      this._roleRepository, this._memberRepository);

  /// Adds a member to the organization
  ///
  /// [UserID] id of the User being added to the organization
  /// Returns a [ResultValue] if successful and [ResultError] if not
  @override
  Future<Result> execute(UserID userID, RoleID roleID,
      OrganizationID organizationID) async {
    User user = await _userRepository.find(userID);
    Role role = await _roleRepository.find(roleID);
    Member member = Member(
        role: role, user: user, organizationID: organizationID);
    Result result = await _memberRepository.store(member);
    return result;
  }
}
