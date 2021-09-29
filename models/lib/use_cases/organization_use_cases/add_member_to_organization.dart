import 'package:async/async.dart';
import 'package:flutter/foundation.dart';
import 'package:models/models/account.dart';
import 'package:models/models/member.dart';
import 'package:models/shared/exceptions.dart';
import 'package:models/shared/exceptions/permission_denied_error.dart';

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
      required AccountID accountID,
      required Role role});
}

class DefaultAddMemberToOrganizationUseCase
    implements AddMemberToOrganizationUseCase {
  AccountRepository _accountRepository;
  MemberRepository _memberRepository;

  DefaultAddMemberToOrganizationUseCase(
      this._accountRepository, this._memberRepository);

  @override
  Future<Result> execute(
      {required MemberID accessorId,
      required AccountID accountID,
      required Role role}) async {
    Member? accessor = await _memberRepository.find(accessorId);
    if (accessor == null) return Result.error(MemberNotFoundError());
    if (accessor.role.permissions < Permissions.maintainer)
      return Result.error(PermissionDeniedError(
          reason:
              "Maintainer permissions required to Add Members to Organization"));

    Account? account = await _accountRepository.find(accountID);
    if (account == null) return Result.error(AccountNotFoundError());

    MemberID? memberId = await _memberRepository.generateNextId();
    if (memberId == null)
      return Result.error(UnableToGenerateIdError(forEntity: "Member"));

    Member member = Member(
        id: memberId,
        name: account.name,
        role: role,
        contact: account.contact,
        organizationID: accessor.organizationID);

    Result result = await _memberRepository.insert(member);
    return result;
  }
}
