import 'package:models/models/organization.dart';

import '../account/mock_account.dart';
import 'mock_organization.dart';

///
/// mock_join_request.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 2/14/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class MockJointRequest {
  final JoinRequest request;

  MockJointRequest({AccountID? accountID, OrganizationID? organizationID})
      : this.request = JoinRequest(
          accountID: accountID ?? MockAccountID().id,
          organizationID: organizationID ?? MockOrganizationID().id,
        );
}
