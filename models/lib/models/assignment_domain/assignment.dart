import 'package:models/models/assignment.dart';
import 'package:models/models/organization.dart';
import 'package:models/shared/domain_driven_design/entity.dart';
import 'package:models/shared/exceptions/exceptions.dart';

///
/// assignment.dart
/// bishopric-assistant
///
/// Created by Joshua Bee on 1/18/22
/// Copyright 2021 Joshua Bee. All rights reserved.
///

class Assignment extends Entity<Assignment> {
  static final String titleKey = "Assignment title";
  static final String isArchivedKey = "Assignment isArchived";
  static final String dueDateKey = "Assignment dueDate";
  static final String assigneeKey = "Assignment Assignee";
  static final String visiblePermissionsKey = "Assignment Visible";
  static final String creatorKey = "Assignment Creator";
  static final String noteKey = "Assignment Note";
  static final String isCompletedKey = "Assignment isCompleted";
  static final String idKey = "Assignment ID";
  static final String orgIDKey = "Assignment Organization Key";

  Assignee assignee;
  bool _isArchived;
  bool _isCompleted;
  late bool _isOverDue;
  late DateTime _dueDate;
  late String _title;
  final Authorization visiblePermissions;
  final Creator creator;
  final Note note;
  final AssignmentID? _id;
  final OrganizationID orgID;

  Assignment({
    AssignmentID? id,
    required this.creator,
    required bool isArchived,
    required this.assignee,
    required bool isCompleted,
    required this.note,
    required String title,
    required DateTime dueDate,
    required this.orgID,
  })  : this._id = id,
        this.visiblePermissions = assignee.authorization,
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
          orgID: OrganizationID(map[orgIDKey]),
        );

  set dueDate(DateTime date) {
    _isOverDue = date.isBefore(DateTime.now());
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

  /// Who can view?
  ///
  /// - Creators of the Assignment
  /// - Assignees assigned to the Assignment
  /// - Permission level of or equal to the Assignment
  bool canView({MemberID? memberID, Authorization? authorization}) {
    if (memberID == creator.id || memberID == assignee.id) return true;
    if (authorization != null && authorization.rank >= 0) return true;
    return false;
  }

  /// Who can archive an assignment?
  ///
  /// - Creators of the assignment
  /// - Assignees assigned to the Assignment
  /// - Permission level of or equal to the Assignment
  bool canArchive({MemberID? memberID, Authorization? authorization}) =>
      canView(memberID: memberID, authorization: authorization);

  /// Who can mark an assignment complete?
  ///
  /// - Creator of organization
  /// - Maintainers of organization
  /// - Assignee of Assignment
  /// - Creator of Assignment
  bool canComplete({MemberID? memberID, Authorization? authorization}) {
    if (memberID == creator.id || memberID == assignee.id) return true;
    if (authorization != null && authorization.rank >= 0)
      return true;
    return false;
  }

  /// Who can edit an assignment?
  ///
  /// - Creator of Assignment
  /// - Assignee of Assignment
  /// - Maintainers or higher Permissions
  bool canEdit({MemberID? memberID, Authorization? authorization}) =>
      canComplete(memberID: memberID, authorization: authorization);

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
        visiblePermissionsKey: visiblePermissions.toMap,
        creatorKey: creator.toMap,
        noteKey: note.toMap,
        isCompletedKey: isCompleted,
        idKey: _id?.id,
        orgIDKey: orgID.id,
      };

  String get title => _title;

  DateTime get dueDate => _dueDate;

  bool get isNotArchived => _isArchived == false;

  bool get isArchived => _isArchived == true;

  bool get isNotCompleted => _isCompleted == false;

  bool get isCompleted => _isCompleted == true;

  bool get isOverDue => _isOverDue;

  AssignmentID get id {
    if (_id == null) throw IdDoesNotExistError(forObject: "Assignment");
    return _id!;
  }

  @override
  String toString() {
    return toMap.toString();
  }
}
