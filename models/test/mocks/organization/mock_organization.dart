import 'package:models/models/organization.dart';

import 'mock_member.dart';

///
/// mock_organization.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 12/2/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class MockOrganization {
  static final String mockName = "Mock Organization";
  late final Organization organization;

  MockOrganization({OrganizationID? id, String? name, Member? creator}) {
    organization = Organization(
        id: id,
        name: name ?? mockName,
        creator: creator ?? MockMember(id: MockMemberID().id).member);
  }
}

class MockOrganizationID {
  static String mockId = "Mock organization ID";
  late OrganizationID id;

  MockOrganizationID({String? id}) {
    this.id = OrganizationID(id ?? mockId);
  }
}
