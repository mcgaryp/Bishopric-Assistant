import 'package:models/models/account.dart';
import 'package:models/models/assignment_domain/creator.dart';
import 'package:models/models/organization.dart';

import '../account/mock_contact.dart';
import '../account/mock_name.dart';
import '../organization/mock_authorization.dart';
import '../organization/mock_member.dart';

///
/// mock_creator.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 1/19/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class MockCreator {
  late final Creator creator;

  MockCreator(
      {Contact? contact, Name? name, MemberID? id, Authorization? authorization}) {
    creator = Creator(
        contact: contact ?? MockContact().contact,
        name: name ?? MockName().name,
        id: id ?? MockMemberID().id,
        authorization: authorization ?? MockAuthorization().authorization);
  }
}
