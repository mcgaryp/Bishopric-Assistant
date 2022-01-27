import 'package:models/models/account.dart';
import 'package:models/models/organization.dart';
import 'package:models/shared/exceptions.dart';

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
  AccountRepository _accountRepository;
  OrganizationRepository _organizationRepository;
  final MemberRepository _memberRepository;

  DefaultAddMemberToOrganizationUseCase(this._accountRepository,
      this._organizationRepository, this._memberRepository);

  @override
  Future<bool> execute({
    required MemberID accessorId,
    required JoinRequest request,
    required Role role,
  }) async {
    Member? accessor = await _memberRepository.find(accessorId);
    if (accessor == null) throw MemberNotFoundError();
    if (accessor.role.permissions < Permissions.maintainer)
      throw PermissionDeniedError(
          reason:
              "Maintainer permissions required to Add Members to Organization");

    Account? account = await _accountRepository.find(request.accountID);
    if (account == null) throw AccountNotFoundError();

    Member member =
        Member(name: account.name, role: role, contact: account.contact);

    Member? memberWithID = await _memberRepository.insert(member);
    if (memberWithID != null) {
      OrganizationMemberRelationship relationship =
          OrganizationMemberRelationship(
              organizationID: request.organizationID,
              memberID: memberWithID.id,
              accountID: request.accountID);
      if (await _organizationRepository.insertRelationship(relationship)) {
        if (await _organizationRepository
            .removeRequestToJoinOrganization(request)) {
          return true;
        } else
          throw FailedToRemoveError(forEntity: "Join Request");
      } else
        throw FailedToSaveError(
            forEntity: "Member Account Organization Relationship");
    }
    throw FailedToSaveError(forEntity: "Member to Organization");
  }
}
