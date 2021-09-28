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
  /// Adds a member to the organization
  ///
  /// [userID] id of the User being added to the organization
  /// [accessorId] id of the member that is adding the user
  /// Returns a [ResultValue] if successful and [ResultError] if not
  @required
  Future<Result> execute(
      {required MemberID accessorId,
      required UserID userID,
      required RoleID roleID});
}

class DefaultAddMemberToOrganizationUseCase
    implements AddMemberToOrganizationUseCase {
  UserRepository _userRepository;
  RoleRepository _roleRepository;
  MemberRepository _memberRepository;

  DefaultAddMemberToOrganizationUseCase(
      this._userRepository, this._roleRepository, this._memberRepository);

  @override
  Future<Result> execute(
      {required MemberID accessorId,
      required UserID userID,
      required RoleID roleID}) async {
    Member? accessor = await _memberRepository.find(accessorId);
    if (accessor!.role.securityClearance < SecurityClearance.level2)
      return Result.error("Access to Add Member Denied.");

    User? user = await _userRepository.find(userID);
    Role? role = await _roleRepository.find(roleID);
    MemberID? memberId = await _memberRepository.generateNextId();
    Member member = Member(
        id: memberId,
        role: role!,
        user: user!,
        organizationID: accessor.organizationID);
    Result result = await _memberRepository.insert(member);
    return result;
  }
}
