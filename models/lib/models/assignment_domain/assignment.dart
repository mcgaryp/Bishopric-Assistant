import 'package:models/models/assignment.dart';
import 'package:models/models/organization.dart';
import 'package:models/shared/domain_driven_design/entity.dart';
import 'package:models/shared/exceptions.dart';

///
/// assignment.dart
/// bishopric-assistant
///
/// Created by Joshua Bee on 9/22/21
/// Copyright 2021 Joshua Bee. All rights reserved.
///

class Assignment extends Entity<Assignment> {
  late String _title;
  bool _isArchived;
  late DateTime _dueDate;
  final Assignee assignee;
  final Permissions visiblePermissions;
  final Creator creator;
  final Note note;
  bool _isCompleted;
  final AssignmentID? _id;

  static final String titleKey = "Assignment title";
  static final String isArchivedKey = "Assignment isArchived";
  static final String dueDateKey = "Assignment dueDate";
  static final String assigneeKey = "Assignment Assignee";
  static final String visiblePermissionsKey = "Assignment Visible";
  static final String creatorKey = "Assignment Creator";
  static final String noteKey = "Assignment Note";
  static final String isCompletedKey = "Assignment isCompleted";
  static final String idKey = "Assignment ID";

  Assignment({
    AssignmentID? id,
    required this.creator,
    required bool isArchived,
    required this.assignee,
    required bool isCompleted,
    required this.note,
    required String title,
    required DateTime dueDate,
  })  : this._id = id,
        this.visiblePermissions = assignee.permissions,
        this._isArchived = isArchived,
        this._isCompleted = isCompleted,
        super(id) {
    this.title = title;
    this.dueDate = dueDate;
  }

  Assignment.fromMap(Map<String, dynamic> map)
      : this(
          id: AssignmentID(map[idKey]),
          creator: Creator.fromMap(map[creatorKey]),
          isArchived: map[isArchivedKey],
          assignee: Assignee.fromMap(map[assigneeKey]),
          isCompleted: map[isCompletedKey],
          note: Note.fromMap(map[noteKey]),
          title: map[titleKey],
          dueDate: DateTime.fromMicrosecondsSinceEpoch(map[dueDateKey]),
        );

  set dueDate(DateTime date) {
    if (date.day < DateTime.now().day)
      throw InvalidDateError(forObject: "Assignment due date");
    _dueDate = date;
  }

  set title(String str) {
    if (str.isEmpty) throw EmptyStringError(forObject: "Assignment title");
    _title = str;
  }

  void archive() => _isArchived = true;

  void unArchive() => _isArchived = false;

  void markComplete() => _isCompleted = true;

  void markIncomplete() => _isCompleted = false;

  @override
  bool sameIdentityAs(Assignment other) {
    return other.title == this.title &&
        other.isArchived == this.isArchived &&
        other.dueDate == this.dueDate &&
        other.assignee == this.assignee &&
        other.visiblePermissions == this.visiblePermissions &&
        other.creator == this.creator &&
        other.note == this.note &&
        other.isCompleted == this.isCompleted;
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != Assignment) return false;
    return sameIdentityAs(other as Assignment);
  }

  @override
  Map<String, dynamic> get toMap => {
        titleKey: title,
        isArchivedKey: isArchived,
        dueDateKey: dueDate.microsecondsSinceEpoch,
        assigneeKey: assignee.toMap,
        visiblePermissionsKey: visiblePermissions.string,
        creatorKey: creator.toMap,
        noteKey: note.toMap,
        isCompletedKey: isCompleted,
        idKey: id.id,
      };

  String get title => _title;

  DateTime get dueDate => _dueDate;

  bool get isArchived => _isArchived;

  bool get isCompleted => _isCompleted;

  AssignmentID get id {
    if (_id == null) throw IdDoesNotExistError(forObject: "Assignment");
    return _id!;
  }
}
