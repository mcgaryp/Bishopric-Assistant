import 'package:models/models/assignment.dart';
import 'package:models/models/organization.dart';
import 'package:models/shared/exceptions/exceptions.dart';

///
/// db_assignment.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 3/25/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class DBAssignment {
  static const String assignmentIDKey = "DB Assignment ID";
  static const String orgIDKey = "DB Assignment Organization ID";
  static const String creatorIDKey = "DB Assignment Creator ID";
  static const String assigneeIDKey = "DB Assignment Assignee ID";
  static const String noteIDKey = "DB Assignment Note ID";
  static const String titleKey = "DB Assignment Title";
  static const String dueDateKey = "DB Assignment Due Date";
  static const String isArchivedKey = "DB Assignment isArchived";
  static const String isCompletedKey = "DB Assignment isCompleted";
  static const String reassignableKey = "DB Assignment reassignable";
  static const String editableKey = "DB Assignment Editable";
  static const String viewersKey = "DB Assignment Viewers";

  List<dynamic> viewers;
  String? assignmentID;
  String? organizationID;
  String? creatorID; // roleID
  String? assigneeID; // roleID
  String? note;
  String? title;
  int? dueDate;
  bool? isArchived;
  bool? isCompleted;
  bool? editable;
  bool? reassignable;

  DBAssignment({
    this.organizationID,
    this.creatorID,
    this.assigneeID,
    this.assignmentID,
    this.dueDate,
    this.isArchived,
    this.isCompleted,
    this.note,
    this.title,
    this.editable,
    this.reassignable,
    this.viewers = const [],
  });

  DBAssignment.fromAssignment(Assignment assignment, {bool hasID = false})
      : this(
          organizationID: assignment.orgID.id,
          creatorID: assignment.creator.id.id,
          assigneeID: assignment.assignee.id.id,
          assignmentID: hasID ? assignment.id.id : null,
          dueDate: assignment.dueDate.microsecondsSinceEpoch,
          isArchived: assignment.isArchived,
          isCompleted: assignment.isCompleted,
          note: assignment.note,
          title: assignment.title,
          editable: assignment.editable,
          reassignable: assignment.reassignable,
          viewers: assignment.viewers.map<String>((Role r) => r.id.id).toList(),
        );

  DBAssignment.fromMap(Map<String, dynamic> map)
      : this(
          organizationID: map[orgIDKey],
          creatorID: map[creatorIDKey],
          assigneeID: map[assigneeIDKey],
          assignmentID: map[assignmentIDKey],
          dueDate: map[dueDateKey],
          isArchived: map[isArchivedKey],
          isCompleted: map[isCompletedKey],
          note: map[noteIDKey],
          title: map[titleKey],
          editable: map[editableKey],
          reassignable: map[reassignableKey],
          viewers: map[viewersKey],
        );

  Map<String, dynamic> get toMap => {
        orgIDKey: organizationID,
        creatorIDKey: creatorID,
        assigneeIDKey: assigneeID,
        assignmentIDKey: assignmentID,
        dueDateKey: dueDate,
        isArchivedKey: isArchived,
        isCompletedKey: isCompleted,
        noteIDKey: note,
        titleKey: title,
        editableKey: editable,
        reassignableKey: reassignable,
        viewersKey: viewers,
      };

  AssignmentID get toAssignmentID {
    assignmentID ?? (throw IdDoesNotExistError(forObject: "DB Assignment ID"));
    return AssignmentID(assignmentID!);
  }

  RoleID get toCreatorID {
    creatorID ??
        (throw IdDoesNotExistError(forObject: "DB Assignment Role ID"));
    return RoleID(creatorID!);
  }

  OrganizationID get toOrganizationID {
    organizationID ??
        (throw IdDoesNotExistError(forObject: "DB Assignment Organization ID"));
    return OrganizationID(organizationID!);
  }

  RoleID get toAssigneeID {
    assigneeID ??
        (throw IdDoesNotExistError(forObject: "DB Assignment Assignee ID"));
    return RoleID(assigneeID!);
  }

  Assignment toAssignment({
    required Role creator,
    required Role assignee,
    required List<Role> viewers,
  }) {
    if (isArchived != null &&
        isCompleted != null &&
        note != null &&
        title != null &&
        dueDate != null &&
        reassignable != null &&
        editable != null) {
      return Assignment(
          isArchived: isArchived!,
          isCompleted: isCompleted!,
          note: note!,
          creator: creator,
          title: title!,
          dueDate: DateTime.fromMicrosecondsSinceEpoch(dueDate!),
          orgID: toOrganizationID,
          assignee: assignee,
          reassignable: reassignable!,
          editable: editable!,
          viewers: viewers,
          id: toAssignmentID);
    }
    throw Exception("Unable to convert DB Assignment to Assignment");
  }
}
