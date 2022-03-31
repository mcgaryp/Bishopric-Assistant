import 'package:models/models/organization.dart';
import 'package:models/shared/exceptions/exceptions.dart';

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

  DefaultRemoveMemberFromOrganizationUseCase(this._memberRepository);

  @override
  Future<bool> execute(
      {required MemberID accessorId, required MemberID memberID}) async {
    // Find member
    Member? accessor = await _memberRepository.find(accessorId);
    if (accessor == null) throw MemberNotFoundError();

    // Find organization
    Organization? organization =
        await _memberRepository.findOrganization(memberID);
    organization ?? (throw OrganizationNotFoundError());

    // TODO: Verify user may remove member
    // if (accessor.role.authorization.rank < 0)
    //   throw PermissionDeniedError(
    //       reason:
    //       "Maintainer permissions required to Remove Members from an Organization");

    // Remove member
    if (await _memberRepository.remove(memberID)) return true;

    throw FailedToRemoveError(
        forEntity: "RemoveMemberFromOrganizationUseCase: Relationship");
  }
}
