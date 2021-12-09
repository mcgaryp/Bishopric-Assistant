import 'package:models/models/organization.dart';
import 'package:models/shared/foundation.dart';

///
/// reject_request_use_case.dart
///
///
/// Created by Porter McGary on 12/9/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

mixin RejectRequestUseCase {
  @required
  Future<void> execute(JoinRequest request);
}

class DefaultRejectRequestUseCase implements RejectRequestUseCase {
  final OrganizationRepository _organizationRepository;

  DefaultRejectRequestUseCase(this._organizationRepository);

  @override
  Future<void> execute(JoinRequest request) async {
    if (!await _organizationRepository.removeRequestToJoinOrganization(request))
      throw FailedToRemoveError(forEntity: "Join Request");
  }
}
