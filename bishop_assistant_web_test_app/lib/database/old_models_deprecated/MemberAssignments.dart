import 'package:bishop_assistant_web_test_app/database/FirestoreDocument.dart';

///
/// MemberAssignments.dart
/// bishop_assistant_web_test_app
///
/// Created by Po on 8/22/21
/// Copyright 2021 Po. All rights reserved.
///
@Deprecated("")
class MemberAssignments extends Document {
  static const String memberId = "member_id";
  static const String organizationAssignmentId = "organization_assignment_id";

  MemberAssignments(int memberID, int organizationAssignmentID)
      : super({
          memberId: memberID,
          organizationAssignmentId: organizationAssignmentID
        });
}
