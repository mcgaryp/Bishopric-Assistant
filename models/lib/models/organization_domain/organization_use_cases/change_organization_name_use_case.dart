import 'package:models/models/organization.dart';
import 'package:models/shared/exceptions/exceptions.dart';

///
/// change_organization_name.dart
/// bishopric-assistant
///
/// Created by Po on 9/24/21
/// Copyright 2021 Po. All rights reserved.
///

mixin ChangeOrganizationNameUseCase {
  /// Changes the name of the organization
  ///
  /// [accessorId] id of the member who is editing the name of the organization
  /// [newName] is the string that will represent the new organization name
  @required
  Future<bool> execute({required MemberID accessorId, required String name});
}

class DefaultChangeOrganizationNameUseCase
    implements ChangeOrganizationNameUseCase {
  OrganizationRepository _organizationRepository;
  MemberRepository _memberRepository;

  DefaultChangeOrganizationNameUseCase(
      this._organizationRepository, this._memberRepository);

  @override
  Future<bool> execute(
      {required MemberID accessorId, required String name}) async {
    // Verify Accessor
    Member? accessor = await _memberRepository.find(accessorId);
    if (accessor == null) throw MemberNotFoundError();

    // Verify Organization
    Organization? organization =
        await _memberRepository.findOrganization(accessor.id);
    if (organization == null) throw OrganizationNotFoundError();

    // Verify Permission to edit
    if (!organization.canEdit(
        authorization: accessor.role.authorization, id: accessorId))
      throw PermissionDeniedError(
          reason: "Must be organization Creator to change name "
              "or have status of creator");

    // Verify Name change
    if (organization.name == name)
      throw FailedToSaveError(
          reason: "New organization name cannot be same as previous");

    // Change name
    organization.name = name;

    // Update name
    if (await _organizationRepository.update(organization)) return true;

    // notify if fails to update
    throw FailedToSaveError(reason: "Organization name failed to update");
  }
}
