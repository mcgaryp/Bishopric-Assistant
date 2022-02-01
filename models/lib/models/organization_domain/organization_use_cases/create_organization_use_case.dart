import 'package:models/models/account.dart';
import 'package:models/models/organization.dart';
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
        OrganizationMemberRelationship relationship =
            OrganizationMemberRelationship(
          accountID: accessor.id,
          organizationID: organizationWithID.id,
          memberID: creatorWithID.id,
        );
        if (await _organizationRepository.insertRelationship(relationship)) {
          return OrganizationMember(
              organization: organizationWithID, member: creatorWithID);
        } else {
          if (await _removeCreator(creatorWithID.id) &&
              await _removeOrganization(organizationWithID.id)) {
            throw FailedToSaveError(
                forEntity: "Organization Member Relationship");
          } else {
            throw FailedToRemoveError(
                forEntity: "The Organization and Creator");
          }
        }
      } else {
        if (await _removeCreator(creatorWithID.id)) {
          throw FailedToSaveError(forEntity: "The Organization");
        } else {
          throw FailedToRemoveError(forEntity: "The Organization Creator");
        }
      }
    } else {
      throw FailedToSaveError(forEntity: "Creator of Organization");
    }
  }

  Future<bool> _removeCreator(MemberID id) {
    return _memberRepository.remove(id);
  }

  Future<bool> _removeOrganization(OrganizationID id) {
    return _organizationRepository.remove(id);
  }
}
