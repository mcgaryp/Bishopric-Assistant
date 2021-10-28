import 'package:bishop_assistant_web_test_app/database/FirestoreDocument.dart';

///
/// OrganizationAssignment.dart
/// bishop_assistant_web_test_app
///
/// Created by Po on 8/22/21
/// Copyright 2021 Po. All rights reserved.
///

class OrganizationAssignments extends Document {
  static const String assignmentId = "assignment_id";
  static const String organizationId = "organization_id";

  OrganizationAssignments(int assignmentID, int organizationID)
      : super({assignmentId: assignmentID, organizationId: organizationID});
}
