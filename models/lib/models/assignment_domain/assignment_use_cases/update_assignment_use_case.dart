import 'package:models/models/assignment.dart';
import 'package:models/models/organization.dart';
import 'package:models/shared/exceptions/exceptions.dart';

///
/// update_assignment_use_case.dart
/// bishopric-assistant
///
/// Created by Joshua Bee on 1/21/22
/// Copyright 2022 Joshua Bee. All rights reserved.
///

mixin UpdateAssignmentUseCase {
  /// Changes specific information in an assignment
  ///
  /// [title] of the assignment
  /// [dueDate] of the assignment
  /// [assignee] of the assignment
  /// [noteContent] of the assignment
  @required
  Future<bool> execute({
    required AssignmentID assignmentID,
    required MemberID memberID,
    String? title,
    DateTime? dueDate,
    Assignee? assignee,
    String? noteContent,
  });
}

class DefaultUpdateAssignmentUseCase implements UpdateAssignmentUseCase {
  final AssignmentRepository _assignmentRepository;
  final MemberRepository _memberRepository;

  DefaultUpdateAssignmentUseCase(
      this._assignmentRepository, this._memberRepository);

  @override
  Future<bool> execute(
      {required AssignmentID assignmentID,
      required MemberID memberID,
      String? title,
      DateTime? dueDate,
      Assignee? assignee,
      String? noteContent}) async {
    Assignment? assignment = await _assignmentRepository.find(assignmentID);
    assignment ?? (throw AssignmentNotFoundError());

    Member? accessor = await _memberRepository.find(memberID);
    accessor ?? (throw MemberNotFoundError());

    if (assignment.canEdit(
        memberID: accessor.id, permissions: accessor.role.permissions)) {
      assignment.title = title ?? assignment.title;
      assignment.dueDate = dueDate ?? assignment.dueDate;
      assignment.assignee = assignee ?? assignment.assignee;
      assignment.note.content = noteContent ?? assignment.note.content;

      return _assignmentRepository.update(assignment);
    }

    throw PermissionDeniedError(
        reason: "Insufficient permissions to update ${assignment.title}");
  }
}
