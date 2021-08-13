///
/// DatabasePaths.dart
/// bishop_assistant_web_test_app
///
/// Created by Porter McGary on 8/13/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

abstract class Document {
  final String name = 'name';
}

enum Collections {
  assignments,
  event_types,
  events,
  member_assignments,
  member_events,
  members,
  organizations,
  organization_assignments,
  organization_events,
  organization_members,
  roles,
  security
}

extension ParseToString on Collections {
  String string() => this.toString().split('.').last;
}

class AssignmentsDoc extends Document {
  static const String dueDate = "due_date";
  static const String notes = "notes";
}

class EventTypesDoc extends Document {}

class EventsDoc extends Document {
  static const String agenda = "agenda";
  static const String date = "date";
  static const String eventType = "event_type";
  static const String interviewee = "interviewee";
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

class MembersDoc extends Document {
  static const String email = "email";
  static const String firstName = "first_name";
  static const String lastName = "last_name";
  static const String password = "password";
  static const String phone = "phone";
  static const String roleId = "role_id";
}

class OrganizationDoc extends Document {}

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

class RolesDoc extends Document {
  final String security = "security";
}

class SecurityDoc extends Document {}
