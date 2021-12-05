import 'package:models/models/organization.dart';
import 'package:models/shared/foundation.dart';

///
/// all_organizations_use_Case.dart
///
///
/// Created by Porter McGary on 12/4/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

mixin AllOrganizationsUseCase {
  @required
  Future<Result<List<Organization>>> execute();
}

class DefaultAllOrganizationsUseCase implements AllOrganizationsUseCase {
  final OrganizationRepository _organizationRepository;

  DefaultAllOrganizationsUseCase(this._organizationRepository);

  @override
  Future<Result<List<Organization>>> execute() async {
    List<Organization>? organizations =
        await _organizationRepository.findAll(null);
    if (organizations == null) return Result.value([]);
    return Result.value(organizations);
  }
}
