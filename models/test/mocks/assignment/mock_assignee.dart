import 'package:models/models/account.dart';
import 'package:models/models/assignment.dart';
import 'package:models/models/organization.dart';

import '../account/mock_contact.dart';
import '../account/mock_name.dart';
import '../organization/mock_member.dart';
import '../organization/mock_permissions.dart';

///
/// mock_assignee.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 1/19/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class MockAssignee {
  late final Assignee assignee;

  MockAssignee(
      {Contact? contact, Name? name, MemberID? id, Permissions? permissions}) {
    assignee = Assignee(
        contact: contact ?? MockContact().contact,
        name: name ?? MockName().name,
        id: id ?? MockMemberID().id,
        permissions: permissions ?? MockPermissions().permissions);
  }
}
