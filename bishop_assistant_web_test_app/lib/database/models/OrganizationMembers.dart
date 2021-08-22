import 'package:bishop_assistant_web_test_app/database/FirestoreDocument.dart';

///
/// OrganizationMembers.dart
/// bishop_assistant_web_test_app
///
/// Created by Po on 8/22/21
/// Copyright 2021 Po. All rights reserved.
///

class OrganizationMembers extends Document {
  static const String memberId = "member_id";
  static const String organizationId = "organization_id";

  OrganizationMembers(int memberID, int organizationID)
      : super({memberId: memberID, organizationId: organizationID});
}
