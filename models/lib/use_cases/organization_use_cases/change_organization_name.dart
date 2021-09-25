import 'package:models/models/member.dart';
import 'package:models/models/organization.dart';
import 'package:models/models/role.dart';

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

  DefaultChangeOrganizationNameUseCase(this._organizationRepository);

  @override
  Future<Result> execute(
      {required MemberID accessorId, required String name}) async {
    Member accessor = await _organizationRepository.findMember(accessorId);
    if (accessor.role.securityClearance < SecurityClearance.creator)
      return Result.error("Access to Change Organization Name Denied.");

    Organization? organization =
        await _organizationRepository.find(accessor.organizationID);
    Organization newOrganization = Organization.newName(organization!, name);
    Result result = await _organizationRepository.update(newOrganization);
    return result;
  }
}
