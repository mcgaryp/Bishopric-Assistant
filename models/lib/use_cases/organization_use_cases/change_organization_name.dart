import 'package:models/models/organization.dart';

///
/// change_organization_name.dart
/// bishopric-assistant
///
/// Created by Po on 9/24/21
/// Copyright 2021 Po. All rights reserved.
///

mixin ChangeOrganizationNameUseCase {
  @required
  Future<Result> execute(OrganizationID organizationID, String name);
}

class DefaultChangeOrganizationNameUseCase
    implements ChangeOrganizationNameUseCase {
  OrganizationRepository _organizationRepository;

  DefaultChangeOrganizationNameUseCase(this._organizationRepository);

  @override
  Future<Result> execute(OrganizationID organizationID, String name) async {
    Organization organization =
        await _organizationRepository.find(organizationID);
    Organization newOrganization = Organization.newName(organization, name);
    Result result = await _organizationRepository.update(newOrganization);
    return result;
  }
}
