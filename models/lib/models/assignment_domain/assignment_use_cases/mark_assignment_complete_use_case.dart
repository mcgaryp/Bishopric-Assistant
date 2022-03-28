import 'package:models/models/assignment.dart';
import 'package:models/models/organization.dart';
import 'package:models/shared/exceptions/exceptions.dart';

///
/// mark_assignment_complete_use_case.dart
/// bishopric-assistant
///
/// Created by Joshua Bee on 1/21/22
/// Copyright 2022 Joshua Bee. All rights reserved.
///

mixin MarkAssignmentCompleteUseCase {
  /// Marks an assignment as complete
  ///
  /// [memberID] id of the person trying to mark it complete
  /// [AssignmentID] id of the assignment in the database
  @required
  Future<bool> execute(
      {required MemberID memberID, required AssignmentID assignmentID});
}

class DefaultMarkAssignmentCompleteUseCase
    implements MarkAssignmentCompleteUseCase {
  final MemberRepository _memberRepository;
  final AssignmentRepository _assignmentRepository;

  DefaultMarkAssignmentCompleteUseCase(
      this._memberRepository, this._assignmentRepository);

  @override
  Future<bool> execute(
      {required MemberID memberID, required AssignmentID assignmentID}) async {
    Member? accessor = await _memberRepository.find(memberID);
    accessor ?? (throw MemberNotFoundError());

    Assignment? assignment = await _assignmentRepository.find(assignmentID);
    assignment ?? (throw AssignmentNotFoundError());

    if (assignment.canComplete(
        authorization: accessor.role.authorization, memberID: accessor.id)) {
      assignment.markComplete();
      return _assignmentRepository.update(assignment);
    }

    throw PermissionDeniedError(
        reason:
            "Insufficient permissions to mark ${assignment.title} complete");
  }
}
