import 'package:models/models/organization.dart';
import 'package:models/models/organization_domain/member_repository.dart';
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
  Future<Result<bool>> execute(
      {required MemberID accessorId, required MemberID memberID});
}

class DefaultRemoveMemberFromOrganizationUseCase
    implements RemoveMemberFromOrganizationUseCase {
  final MemberRepository _repository;

  DefaultRemoveMemberFromOrganizationUseCase(this._repository);

  @override
  Future<Result<bool>> execute(
      {required MemberID accessorId, required MemberID memberID}) async {
    Member? accessor = await _repository.find(accessorId);
    if (accessor == null) return Result.error(MemberNotFoundError());
    if (accessor.role.permissions < Permissions.maintainer)
      return Result.error(PermissionDeniedError(
          reason:
              "Maintainer permissions required to Remove Members from an Organization"));

    Result<bool> result = await _repository.remove(memberID);
    if (result.isValue) return Result.value(true);
    return result;
  }
}
