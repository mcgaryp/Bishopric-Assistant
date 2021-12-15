import 'package:models/models/organization.dart';
import 'package:models/models/organization_domain/member_repository.dart';
import 'package:models/shared/exceptions.dart';

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
  Future<bool> execute({
    required MemberID accessorID,
    required MemberID memberID,
    required Role role,
  });
}

class DefaultChangeMemberRoleInOrganizationUseCase
    implements ChangeMemberRoleInOrganizationUseCase {
  final MemberRepository _memberRepository;

  DefaultChangeMemberRoleInOrganizationUseCase(this._memberRepository);

  @override
  Future<bool> execute({
    required MemberID accessorID,
    required MemberID memberID,
    required Role role,
  }) async {
    Member? accessor = await _memberRepository.find(accessorID);
    if (accessor == null) throw MemberNotFoundError();
    if (accessor.role.permissions < Permissions.maintainer)
      return throw PermissionDeniedError(
          reason:
              "Maintainer permissions required to change a Role of Organization Member");

    Member? member = await _memberRepository.find(memberID);
    if (member == null) throw MemberNotFoundError();
    Member updatedMember = Member.newRole(role: role, member: member);
    if (await _memberRepository.update(updatedMember)) return true;
    throw FailedToSaveError(forEntity: "Organization");
  }
}
