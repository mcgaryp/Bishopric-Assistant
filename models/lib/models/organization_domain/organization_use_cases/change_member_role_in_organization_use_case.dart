import 'package:models/models/organization.dart';
import 'package:models/shared/exceptions/exceptions.dart';

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
    // Check the accessors Organization
    Organization? accessorOrganization =
        await _memberRepository.findOrganization(accessorID);
    accessorOrganization ?? (throw OrganizationNotFoundError());

    // Member Organization
    Organization? memberOrganization =
        await _memberRepository.findOrganization(memberID);
    memberOrganization ?? (throw OrganizationNotFoundError());

    // Ensure they are the same
    if (memberOrganization != accessorOrganization)
      throw PermissionDeniedError(
          reason: "Accessor is not in the same organization as the member");

    // Check accessor validity
    Member? accessor = await _memberRepository.find(accessorID);
    if (accessor == null) throw MemberNotFoundError();

    // Check that member can change the role of members
    if (!memberOrganization.canEditRoles(
        authorization: accessor.role.authorization, id: accessor.id))
      throw PermissionDeniedError(
          reason: "Insufficient permission to change member role");

    // Find the member that is going to change
    Member? member = await _memberRepository.find(memberID);
    if (member == null) throw MemberNotFoundError();

    //change the role
    member.role = role;

    // Update
    if (await _memberRepository.update(member)) return true;

    // Notify of fail to save
    throw FailedToSaveError(reason: "Organization");
  }
}
