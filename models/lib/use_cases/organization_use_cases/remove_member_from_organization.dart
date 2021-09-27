import 'package:models/models/member.dart';
import 'package:models/models/role.dart';

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
  Future<Result> execute(
      {required MemberID accessorId, required MemberID memberID});
}

class DefaultRemoveMemberFromOrganizationUseCase
    implements RemoveMemberFromOrganizationUseCase {
  MemberRepository _memberRepository;

  DefaultRemoveMemberFromOrganizationUseCase(this._memberRepository);

  @override
  Future<Result> execute(
      {required MemberID accessorId, required MemberID memberID}) async {
    Member? accessor = await _memberRepository.find(accessorId);
    if (accessor!.role.securityClearance < SecurityClearance.level1)

      /// TODO: Does this belong here?
      /// TODO: Make these more specific for logging purposes
      return Result.error("Access to Remove Member Denied");

    Result result = await _memberRepository.remove(memberID);
    return result;
  }
}
