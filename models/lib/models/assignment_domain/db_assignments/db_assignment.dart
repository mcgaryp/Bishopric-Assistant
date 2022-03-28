import 'package:models/models/assignment.dart';
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

  String? assignmentID;
  String? organizationID;
  String? creatorID; // roleID
  String? assigneeID; // roleID
  String? noteID;
  String? title;
  int? dueDate;
  bool? isArchived;
  bool? isCompleted;

  DBAssignment({
    this.organizationID,
    this.creatorID,
    this.assigneeID,
    this.assignmentID,
    this.dueDate,
    this.isArchived,
    this.isCompleted,
    this.noteID,
    this.title,
  });

  DBAssignment.fromMap(Map<String, dynamic> map) : this(
    organizationID: map[orgIDKey],
    creatorID: map[creatorIDKey],
    assigneeID: map[assigneeIDKey],
    assignmentID: map[assignmentIDKey],
    dueDate: map[dueDateKey],
    isArchived: map[isArchivedKey],
    isCompleted: map[isCompletedKey],
    noteID: map[noteIDKey],
    title: map[titleKey],
  );

  Map<String, dynamic> get toMap => {
    orgIDKey:organizationID,
    creatorIDKey: creatorID,
    assigneeIDKey: assigneeID,
    assignmentIDKey: assignmentID,
    dueDateKey: dueDate,
    isArchivedKey: isArchived,
    isCompletedKey: isCompleted,
    noteIDKey: noteID,
    titleKey: title,
  };

  AssignmentID get toAssignmentID {
    assignmentID ?? (throw IdDoesNotExistError(forObject: "DB Assignment ID"));
    return AssignmentID(assignmentID!);
  }
}
