import 'package:models/models/organization.dart';
import 'package:models/shared/exceptions.dart';

///
/// remove_member_from_organization.dart
/// bishopric-assistant
///
/// Created by Po on 9/23/21
/// Copyright 2021 Po. All rights reserved.
///

mixin RemoveMemberFromOrganizationUseCase {
  /// Removes a member from the organization
  ///
  /// [memberID] id of the member being removed from the organization
  /// [accessorID] id of the member that is attempting to remove [memberId]
  /// Returns a [ResultValue] if successful else returns [ResultError]
  @required
  Future<bool> execute(
      {required MemberID accessorId, required MemberID memberID});
}

class DefaultRemoveMemberFromOrganizationUseCase
    implements RemoveMemberFromOrganizationUseCase {
  final MemberRepository _memberRepository;
  final OrganizationRepository _organizationRepository;

  DefaultRemoveMemberFromOrganizationUseCase(
      this._memberRepository, this._organizationRepository);

  @override
  Future<bool> execute(
      {required MemberID accessorId, required MemberID memberID}) async {
    Member? accessor = await _memberRepository.find(accessorId);
    if (accessor == null) throw MemberNotFoundError();
    if (accessor.role.permissions < Permissions.Maintainer)
      throw PermissionDeniedError(
          reason:
              "Maintainer permissions required to Remove Members from an Organization");

    Organization? organization =
        await _memberRepository.findOrganization(memberID);
    organization ?? (throw OrganizationNotFoundError());

    List<OrganizationMemberRelationship> relationships =
        await _organizationRepository.findAllRelationships(organization.id);

    for (OrganizationMemberRelationship relationship in relationships) {
      if (relationship.memberID == memberID &&
          relationship.organizationID == organization.id) {
        if (await _organizationRepository.removeRelationship(relationship)) {
          return await _memberRepository.remove(memberID);
        } else {
          // TODO: place member back in repository
          throw FailedToRemoveError(
              forEntity: "RemoveMemberFromOrganizationUseCase");
        }
      }
    }
    // TODO: place member back in repository
    throw FailedToRemoveError(
        forEntity: "RemoveMemberFromOrganizationUseCase: Relationship");
  }
}
