import 'package:models/models/member.dart';
import 'package:models/models/organization.dart';
import 'package:models/models/role.dart';

///
/// change_member_role_in_organization.dart
/// bishopric-assistant
///
/// Created by Po on 9/23/21
/// Copyright 2021 Po. All rights reserved.
///

mixin ChangeMemberRoleInOrganizationUseCase {
  /// Changes the role of a member in the organization
  ///
  /// [memberID] of the member whose role is changing
  /// [accessorID] of the member whose changing the [memberID] role
  /// [newRole] the new role of the [memberID]
  /// Returns a [ResultValue] if successful else[ResultError]
  @required
  Future<Result> execute({
    required MemberID accessorId,
    required MemberID memberID,
    required RoleID roleID,
  });
}

class DefaultChangeMemberRoleInOrganizationUseCase
    implements ChangeMemberRoleInOrganizationUseCase {
  MemberRepository _memberRepository;
  RoleRepository _roleRepository;

  DefaultChangeMemberRoleInOrganizationUseCase(
      this._memberRepository, this._roleRepository);

  @override
  Future<Result> execute({
    required MemberID accessorId,
    required MemberID memberID,
    required RoleID roleID,
  }) async {
    Member? creator = await _memberRepository.find(accessorId);
    if (creator!.role.securityClearance < SecurityClearance.creator)
      return Result.error("Access to Change Member Role Denied.");

    Role? newRole = await _roleRepository.find(roleID);
    Member? member = await _memberRepository.find(memberID);
    Member updatedMember = Member.newRole(role: newRole!, member: member!);
    Result result = await _memberRepository.update(updatedMember);
    return result;
  }
}
