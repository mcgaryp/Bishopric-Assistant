import 'package:models/models/assignment.dart';
import 'package:models/models/organization.dart';

///
/// organization_assignment_relationship.dart
/// bishopric-assistant
///
/// Created by Po. on 1/21/22
/// Copyright 2021 Po. All rights reserved.
///

class OrganizationAssignmentRelationship {
  static final String organizationKey = "organizationID";
  static final String assignmentKey = "assignmentID";

  final OrganizationID organizationID;
  final AssignmentID assignmentID;

  OrganizationAssignmentRelationship(
      {required this.assignmentID, required this.organizationID});

  Map<String, dynamic> get toMap =>
      {organizationKey: organizationID, assignmentKey: assignmentID};
}
