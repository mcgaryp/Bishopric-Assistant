import 'package:flutter/foundation.dart';
import 'package:models/models/account.dart';
import 'package:models/models/organization.dart';
import 'package:models/models/organization_domain/member_repository.dart';
import 'package:models/shared/exceptions.dart';

///
/// create_organization.dart
/// bishopric-assistant
///
/// Created by Po on 9/23/21
/// Copyright 2021 Po. All rights reserved.
///

mixin CreateOrganizationUseCase {
  /// Creates a new organization
  ///
  /// [creatorId] id of the creator of the organization
  /// [name] given to the new organization
  /// returns a [ResultValue] if successful else [ResultError]
  @required
  Future<OrganizationMember> execute(
      {required AccountID creatorId, required String name, String? anonymous});
}

class DefaultCreateOrganizationUseCase implements CreateOrganizationUseCase {
  final AccountRepository _accountRepository;
  final OrganizationRepository _organizationRepository;
  final MemberRepository _memberRepository;

  DefaultCreateOrganizationUseCase(this._accountRepository,
      this._organizationRepository, this._memberRepository);

  @override
  Future<OrganizationMember> execute(
      {required AccountID creatorId,
      required String name,
      String? anonymous}) async {
    Account? accessor = await _accountRepository.find(creatorId);
    if (accessor == null) throw AccountNotFoundError();
    Organization? organizationFromBeyond =
        await _organizationRepository.findByName(name);
    if (organizationFromBeyond != null) throw OrganizationAlreadyExistsError();
    Member creator = Member(
        name: accessor.name, contact: accessor.contact, role: Role.creator());
    Member? creatorWithID = await _memberRepository.insert(creator);
    if (creatorWithID != null) {
      Organization organization =
          Organization(name: name, creator: creatorWithID);
      Organization? organizationWithID =
          await _organizationRepository.insert(organization);
      if (organizationWithID != null) {
        print("Test 1");
        if (await _organizationRepository.insertRelationship(
            organizationWithID.id, creatorWithID.id, accessor.id)) {
          return OrganizationMember(
              organization: organizationWithID, member: creatorWithID);
        } else
          // TODO: Remove the Creator from Repo
          // TODO: Remove Organization from Repo
          throw FailedToSaveError(
              forEntity: "Organization Member Relationship");
      } else
        // TODO: Remove the Creator from Repo
        throw FailedToSaveError(forEntity: "The Organization");
    } else
      throw FailedToSaveError(forEntity: "Creator of Organization");
  }
}
