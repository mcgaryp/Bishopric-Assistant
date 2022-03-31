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
  static final String reassignableKey = "Assignment Reassignable";
  static final String editableKey = "Assignment Editable";
  static final String viewersKey = "Assignment Viewers";

  late DateTime _dueDate;
  late String _title;
  late bool _isOverDue;
  bool _isArchived;
  bool _isCompleted;
  bool editable;
  bool reassignable;
  String note;
  List<Role> viewers;
  Role assignee;
  final Role creator;
  final AssignmentID? _id;
  final OrganizationID orgID;

  Assignment({
    AssignmentID? id,
    required bool isArchived,
    required bool isCompleted,
    required this.note,
    required this.creator,
    required String title,
    required DateTime dueDate,
    required this.orgID,
    required this.assignee,
    required this.reassignable,
    required this.editable,
    required this.viewers,
  })  : this._id = id,
        this._isArchived = isArchived,
        this._isCompleted = isCompleted,
        super(id) {
    this.title = title;
    this.dueDate = dueDate;
  }

  Assignment.fromMap(Map<String, dynamic> map)
      : this(
          id: AssignmentID(map[idKey]),
          isArchived: map[isArchivedKey],
          assignee: Role.fromMap(map[assigneeKey]),
          isCompleted: map[isCompletedKey],
          title: map[titleKey],
          dueDate: DateTime.fromMicrosecondsSinceEpoch(map[dueDateKey]),
          orgID: OrganizationID(map[orgIDKey]),
          creator: Role.fromMap(map[creatorKey]),
          note: map[noteKey],
          editable: map[editableKey],
          reassignable: map[reassignableKey],
          viewers: map[viewersKey],
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
  bool canView(
      {RoleID? roleID,
      @Deprecated("not in use") MemberID? memberID,
      @Deprecated("Not in use") Authorization? authorization}) {
    if (roleID == creator.id || roleID == assignee.id) return true;
    // if (authorization != null && authorization.rank >= 0) return true;
    return false;
  }

  /// Who can archive an assignment?
  ///
  /// - Creators of the assignment
  /// - Assignees assigned to the Assignment
  /// - Permission level of or equal to the Assignment
  bool canArchive(
          {RoleID? roleID,
          @Deprecated("not in use") MemberID? memberID,
          @Deprecated("not in use") Authorization? authorization}) =>
      canView(roleID: roleID);

  /// Who can mark an assignment complete?
  ///
  /// - Creator of organization
  /// - Maintainers of organization
  /// - Assignee of Assignment
  /// - Creator of Assignment
  bool canComplete(
      {RoleID? roleID,
      @Deprecated("not in use") MemberID? memberID,
      @Deprecated("not in use") Authorization? authorization}) {
    if (roleID == creator.id || roleID == assignee.id) return true;
    // if (authorization != null && authorization.rank >= 0) return true;
    return false;
  }

  /// Who can edit an assignment?
  ///
  /// - Creator of Assignment
  /// - Assignee of Assignment
  /// - Maintainers or higher Permissions
  bool canEdit(
          {RoleID? roleID,
          @Deprecated("not in use") MemberID? memberID,
          @Deprecated("not in use") Authorization? authorization}) =>
      canComplete(roleID: roleID);

  /// Who can reassign the Assignment
  bool canReassign({RoleID? roleID}) {
    if (roleID == creator.id || (roleID == assignee.id && reassignable))
      return true;
    return false;
  }

  @override
  bool sameIdentityAs(Assignment other) {
    return other.title == this.title &&
        other.isArchived == this.isArchived &&
        other.dueDate == this.dueDate &&
        other.assignee == this.assignee &&
        other.creator == this.creator &&
        other.note == this.note &&
        other.isCompleted == this.isCompleted &&
        other.reassignable == this.reassignable &&
        other.editable == this.editable;
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
        creatorKey: creator.toMap,
        noteKey: note,
        isCompletedKey: isCompleted,
        idKey: _id?.id,
        orgIDKey: orgID.id,
        reassignableKey: reassignable,
        editableKey: editable,
        viewersKey: viewers
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
