///
/// constants.dart.dart
/// Bishop Assistant Web Test
///
/// Created by Porter McGary on 8/8/2021
/// Copyright 2021 Porter McGary. All rights reserved.
///

class Collections {
  final String value;
  Collections(this.value);

  static const String assignments = "Assignments";
  static const String eventTypes = "Event Types";
  static const String events = "Events";
  static const String memberAssignments = "Member Assignments";
  static const String memberEvents = "Member Events";
  static const String members = "Members";
  static const String organizations = "Organization";
  static const String organizationAssignments = "Organization Assignments";
  static const String organizationEvents = "Organization Events";
  static const String organizationMembers = "Organization Members";
  static const String roles = "Roles";
  static const String security = "Security";
}

class AssignmentsDoc {
  static const String dueDate = "due_date";
  static const String label = "label";
  static const String notes = "notes";
}

class EventTypesDoc {
  static const String name = "name";
}

class EventsDoc {
  static const String agenda = "agenda";
  static const String date = "date";
  static const String eventType = "event_type";
  static const String interviewee = "interviewee";
  static const String name = "name";
  static const String notes = "notes";
  static const String place = "place";
}

class MemberAssignmentsDoc {
  static const String memberId = "member_id";
  static const String organizationAssignmentId = "organization_assignment_id";
}

class MemberEventsDoc {
  static const String memberId = "member_id";
  static const String organizationEventId = "organization_event_id";
}

class MembersDoc {
  static const String email = "email";
  static const String firstName = "first_name";
  static const String lastName = "last_name";
  static const String password = "password";
  static const String phone = "phone";
  static const String roleId = "role_id";
}

class OrganizationDoc {
  static const String name = "name";
}

class OrganizationAssignmentsDoc {
  static const String assignmentId = "assignment_id";
  static const String organizationId = "organization_id";
}

class OrganizationEventsDoc {
  static const String eventId = "event_id";
  static const String organizationId = "organization_id";
}

class OrganizationMembersDoc {
  static const String memberId = "member_id";
  static const String organizationId = "organization_id";
}

class RolesDoc {
  static const String name = "name";
  static const String security = "security";
}

class SecurityDoc {
  static const String name = "name";
}

class Constant {}
