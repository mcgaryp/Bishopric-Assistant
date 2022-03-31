import 'package:models/models/account.dart';
import 'package:models/models/organization.dart';
import 'package:models/shared/exceptions/exceptions.dart';

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
  Future<bool> execute({
    required AccountID creatorId,
    required String name,
    required List<Role> roles,
    required List<Authorization> authorizations,
    required Role creatorRole,
  });
}

class DefaultCreateOrganizationUseCase implements CreateOrganizationUseCase {
  final AccountRepository _accountRepository;
  final OrganizationRepository _organizationRepository;
  final MemberRepository _memberRepository;
  final RoleRepository _roleRepository;
  final AuthorizationRepository _authorizationRepository;

  DefaultCreateOrganizationUseCase(
      this._accountRepository,
      this._organizationRepository,
      this._memberRepository,
      this._roleRepository,
      this._authorizationRepository);

  @override
  Future<bool> execute({
    required AccountID creatorId,
    required String name,
    required List<Role> roles,
    required List<Authorization> authorizations,
    required Role creatorRole,
  }) async {
    // find the account
    Account? accessor = await _accountRepository.find(creatorId);
    if (accessor == null) throw AccountNotFoundError();

    // check if organization exists
    Organization? organizationFromBeyond =
        await _organizationRepository.findByName(name);
    if (organizationFromBeyond != null) throw OrganizationAlreadyExistsError();

    // insert organization name
    OrganizationID? organizationID = await _organizationRepository.insert(name);
    organizationID ?? (throw IdDoesNotExistError(forObject: "OrganizationID"));

    // Insert the Roles
    RoleID? roleID;
    for (Role role in roles) {
      if (role == creatorRole) {
        roleID = await _roleRepository.insert(role, organizationID);
      } else {
        await _roleRepository.insert(role, organizationID);
      }
    }

    if (roleID == null) throw FailedToSaveError(reason: "Creator Role");

    // Insert the Authorizations
    for (Authorization auth in authorizations) {
      await _authorizationRepository.insert(auth, organizationID);
    }

    // Update creatorRole with proper IDs
    List<Authorization> auths =
        await _authorizationRepository.findAll(organizationID);
    Authorization authorizationWithID = auths.firstWhere(
        (Authorization a) => a.rank == creatorRole.authorization.rank);
    creatorRole = Role(
      name: creatorRole.name,
      id: roleID,
      authorization: authorizationWithID,
    );

    // Create Member
    Member creator = Member(
        name: accessor.name, contact: accessor.contact, role: creatorRole);

    // insert member
    if (await _memberRepository.insert(creator, organizationID, creatorId)) {
      // update organization with creator ID
      Member? member = await _memberRepository.findWithAccountID(creatorId);
      member ?? (throw MemberNotFoundError());
      Organization organization =
          Organization(name: name, creator: member, id: organizationID);
      return _organizationRepository.update(organization);
    }
    throw FailedToSaveError(reason: "Create Organization");
  }
}
