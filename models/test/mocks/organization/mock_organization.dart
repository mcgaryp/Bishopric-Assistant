import 'package:models/models/organization.dart';
import 'package:models/models/organization_domain/member.dart';

import 'mock_member.dart';

///
/// mock_organization.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 12/2/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class MockOrganization {
  static final Member mockCreator = MockMember(role: Role.creator()).member;
  static final String mockName = "Mock Organization";
  static final OrganizationID mockId = OrganizationID("Mock Organization ID");

  late final Organization organization;

  MockOrganization({OrganizationID? id, String? name, Member? creator}) {
    organization = Organization(
        id: id ?? mockId,
        name: name ?? mockName,
        creator: creator ?? mockCreator);
  }
}
