import 'package:models/models/account.dart';
import 'package:models/models/organization.dart';
import 'package:models/shared/exceptions/exceptions.dart';

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
  Future<bool> execute({
    required MemberID accessorId,
    required JoinRequest request,
    required Role role,
  });
}

class DefaultAddMemberToOrganizationUseCase
    implements AddMemberToOrganizationUseCase {
  final AccountRepository _accountRepository;
  final OrganizationRepository _organizationRepository;
  final MemberRepository _memberRepository;
  final JoinRequestRepository _requestRepository;

  DefaultAddMemberToOrganizationUseCase(
      this._accountRepository,
      this._organizationRepository,
      this._memberRepository,
      this._requestRepository);

  @override
  Future<bool> execute({
    required MemberID accessorId,
    required JoinRequest request,
    required Role role,
  }) async {
    // verify accessor
    Member? accessor = await _memberRepository.find(accessorId);
    if (accessor == null) throw MemberNotFoundError();

    // Verify Organization
    Organization? organization =
        await _organizationRepository.find(request.organizationID);
    organization ?? (throw OrganizationNotFoundError());

    // Verify accessor has permission to add or remove member from organization
    if (!organization.canAddRemove(
        authorization: accessor.role.authorization, id: accessorId))
      throw PermissionDeniedError(
          reason:
              "Maintainer permissions required to Add Members to Organization");

    // Find new member account
    Account? account = await _accountRepository.find(request.accountID);
    if (account == null) throw AccountNotFoundError();

    // Create new Member
    Member member =
        Member(name: account.name, role: role, contact: account.contact);

    // Insert new member
    if (await _memberRepository.insert(member, organization.id, account.id)) {
      // remove join request
      return _requestRepository.remove(request.id);
    }

    throw FailedToSaveError(reason: "Member");
  }
}
