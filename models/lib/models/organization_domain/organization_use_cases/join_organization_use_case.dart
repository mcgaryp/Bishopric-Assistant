import 'package:models/models/organization.dart';
import 'package:models/shared/foundation.dart';

///
/// join_organization_use_case.dart
///
///
/// Created by Porter McGary on 12/5/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

mixin JoinOrganizationUseCase {
  @required
  Future<bool> execute(
      {required AccountID accountID, required OrganizationID organizationID});
}

class DefaultJoinOrganizationUseCase implements JoinOrganizationUseCase {
  final OrganizationRepository _organizationRepository;

  DefaultJoinOrganizationUseCase(this._organizationRepository);

  @override
  Future<bool> execute(
      {required AccountID accountID,
      required OrganizationID organizationID}) async {
    JoinRequest request =
        JoinRequest(accountID: accountID, organizationID: organizationID);

    return _organizationRepository.requestToJoinOrganization(request);
  }
}
