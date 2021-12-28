import 'package:models/models/organization.dart';

///
/// all_organization_requests_use_case.dart
///
///
/// Created by Porter McGary on 12/8/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

mixin AllOrganizationRequestsUseCase {
  @required
  Stream<List<JoinRequest>> execute(OrganizationID organizationID);
}

class DefaultAllOrganizationRequestsUseCase
    implements AllOrganizationRequestsUseCase {
  final OrganizationRepository _organizationRepository;

  DefaultAllOrganizationRequestsUseCase(this._organizationRepository);

  @override
  Stream<List<JoinRequest>> execute(OrganizationID organizationID) {
    return _organizationRepository.findAllRequests(organizationID);
  }
}
