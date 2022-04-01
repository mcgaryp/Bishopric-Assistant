import 'package:the_assistant/widgets/calendar/calendar.dart';
import 'package:models/models/assignment.dart';
import 'package:models/models/organization.dart';

///
/// assignment_calendar_event.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 2/7/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class AssignmentCalendarEvent extends CalendarEvent {
  AssignmentCalendarEvent(Assignment assignment)
      : super(assignment.dueDate, assignment.title);
}

class AssignmentCalendarEvents {
  final OrganizationID organizationID;

  AssignmentCalendarEvents(this.organizationID);

  List<AssignmentCalendarEvent> getAssignments() {
    // TODO Get all assignments from organization UseCase
    // TODO Convert them into AssignmentCalendarEvent
    // return the list
    return [];
  }
}
