import 'package:models/models/organization.dart';
import 'package:models/models/organization_domain/member_repository.dart';
import 'package:models/shared/exceptions.dart';

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
  Future<Result> execute({required MemberID accessorId, required String name});
}

class DefaultChangeOrganizationNameUseCase
    implements ChangeOrganizationNameUseCase {
  OrganizationRepository _organizationRepository;
  MemberRepository _memberRepository;

  DefaultChangeOrganizationNameUseCase(
      this._organizationRepository, this._memberRepository);

  @override
  Future<Result> execute(
      {required MemberID accessorId, required String name}) async {
    Member? accessor = await _memberRepository.find(accessorId);
    if (accessor == null) return Result.error(MemberNotFoundError());
    if (accessor.role.permissions < Permissions.creator)
      return Result.error(PermissionDeniedError(
          reason: "Creator Permissions required to Change Organization Name"));

    Organization? organization =
        await _memberRepository.findOrganization(accessor.memberID);
    if (organization == null) return Result.error(OrganizationNotFoundError());
    Organization newOrganization = Organization.newName(organization, name);
    if (await _organizationRepository.update(newOrganization))
      return Result.value(true);
    return Result.error(FailedToSaveError(forEntity: "Organization"));
  }
}