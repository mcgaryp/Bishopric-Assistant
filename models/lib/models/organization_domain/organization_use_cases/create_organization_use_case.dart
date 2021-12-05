import 'package:async/async.dart';
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
  Future<Result<Organization>> execute(
      {required AccountID creatorId, required String name, String? anonymous});
}

class DefaultCreateOrganizationUseCase implements CreateOrganizationUseCase {
  final AccountRepository _accountRepository;
  final OrganizationRepository _organizationRepository;
  final MemberRepository _memberRepository;

  DefaultCreateOrganizationUseCase(this._accountRepository,
      this._organizationRepository, this._memberRepository);

  @override
  Future<Result<Organization>> execute(
      {required AccountID creatorId,
      required String name,
      String? anonymous}) async {
    Account? accessor = await _accountRepository.find(creatorId);
    if (accessor == null) return Result.error(AccountNotFoundError());
    OrganizationID? id = await _organizationRepository.generateNextId();

    if (id == null)
      return Result.error(UnableToGenerateIdError(forEntity: "Organization"));

    Organization? organizationFromBeyond =
        await _organizationRepository.find(id);
    if (organizationFromBeyond != null)
      return Result.error(OrganizationAlreadyExistsError());

    MemberID? memberID = await _memberRepository.generateNextId();
    Member creator;
    if (memberID == null)
      return Result.error(UnableToGenerateIdError(forEntity: "Member"));
    creator = Member(
        memberID: memberID,
        name: accessor.name,
        contact: accessor.contact,
        role: Role.creator());
    Organization organization =
        Organization(id: id, name: name, creator: creator);

    if (await _organizationRepository.insert(organization)) {
      if (await _memberRepository.insert(creator)) {
        if (await _organizationRepository.insertRelationship(
            organization.id, creator.memberID, accessor.id)) {
          return Result.value(organization);
        } else
          return Result.error(
              FailedToSaveError(forEntity: "Organization Member Relationship"));
      } else
        return Result.error(
            FailedToSaveError(forEntity: "Organization Creator"));
    } else
      return Result.error(FailedToSaveError(forEntity: "Organization"));
  }
}
