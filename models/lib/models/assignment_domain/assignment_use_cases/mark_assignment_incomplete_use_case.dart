import 'package:models/models/assignment.dart';
import 'package:models/models/organization.dart';
import 'package:models/shared/exceptions.dart';

///
/// mark_assignment_incomplete_use_case.dart
/// bishopric-assistant
///
/// Created by Joshua Bee on 1/21/22
/// Copyright 2022 Joshua Bee. All rights reserved.
///

mixin MarkAssignmentIncompleteUseCase {
  /// Marks an assignment as incomplete
  ///
  /// [memberID] id of the person trying to mark it incomplete
  /// [AssignmentID] id of the assignment in the database
  @required
  Future<bool> execute(
      {required MemberID memberID, required AssignmentID assignmentID});
}

class DefaultMarkAssignmentIncompleteUseCase
    implements MarkAssignmentIncompleteUseCase {
  final MemberRepository _memberRepository;
  final AssignmentRepository _assignmentRepository;

  DefaultMarkAssignmentIncompleteUseCase(
      this._memberRepository, this._assignmentRepository);

  @override
  Future<bool> execute(
      {required MemberID memberID, required AssignmentID assignmentID}) async {
    Member? accessor = await _memberRepository.find(memberID);
    accessor ?? (throw MemberNotFoundError());

    Assignment? assignment = await _assignmentRepository.find(assignmentID);
    assignment ?? (throw AssignmentNotFoundError());

    if (accessor.role.permissions <= assignment.visiblePermissions)
      throw PermissionDeniedError(
          reason:
              "Accessor does not have rights to mark assignment incomplete");

    assignment.markIncomplete();

    return true;
  }
}