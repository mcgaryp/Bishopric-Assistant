import 'package:models/models/organization.dart';
import 'package:models/shared/foundation.dart';

///
/// delete_organization.dart
///
///
/// Created by Porter McGary on 12/2/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

mixin DeleteOrganizationUseCase {
  /// Removes an organization and its members
  ///
  /// [creatorID] id of the creator who is the only one with access to remove
  /// the organization
  /// [organizationID] of the organization being removed
  /// Returns a [ResultValue] if successful else returns [ResultError]
  @required
  Future<bool> execute(
      {required MemberID creatorID, required OrganizationID organizationID});
}

class DefaultDeleteOrganizationUseCase implements DeleteOrganizationUseCase {
  final OrganizationRepository _organizationRepository;
  final MemberRepository _memberRepository;

  DefaultDeleteOrganizationUseCase(
      this._organizationRepository, this._memberRepository);

  @override
  Future<bool> execute(
      {required MemberID creatorID,
      required OrganizationID organizationID}) async {
    Member? creator = await _memberRepository.find(creatorID);
    if (creator == null) throw MemberNotFoundError();
    Organization? organization =
        await _organizationRepository.find(organizationID);
    if (organization == null) throw OrganizationNotFoundError();
    if (organization.creator != creator)
      throw PermissionDeniedError(
          reason: "Only creators can delete organizations");

    return await _organizationRepository.remove(organizationID);
  }
}
