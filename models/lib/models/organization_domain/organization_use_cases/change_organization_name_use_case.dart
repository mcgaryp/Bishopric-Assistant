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
    Member? accessor = await _memberRepository.find(accessorId);
    if (accessor == null) throw MemberNotFoundError();

    Organization? organization =
        await _memberRepository.findOrganization(accessor.id);
    if (organization == null) throw OrganizationNotFoundError();

    if (!organization.canEdit(
        permissions: accessor.role.permissions, id: accessorId))
      throw PermissionDeniedError(
          reason: "Must be organization Creator to change name "
              "or have status of creator");

    if (organization.name == name)
      throw FailedToSaveError(
          reason: "New organization name cannot be same as previous");

    organization.name = name;

    if (await _organizationRepository.update(organization)) return true;

    throw FailedToSaveError(reason: "Organization name failed to update");
  }
}
