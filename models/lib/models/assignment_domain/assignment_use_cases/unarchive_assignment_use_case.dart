import 'package:models/models/assignment.dart';
import 'package:models/models/organization.dart';
import 'package:models/shared/exceptions.dart';

///
/// get_assignment_from_archive_use_case.dart
/// bishopric-assistant
///
/// Created by Joshua Bee on 1/21/22
/// Copyright 2022 Joshua Bee. All rights reserved.
///

mixin UnarchiveAssignmentUseCase {
  /// Gets an assignment from the archive
  ///
  /// [memberID] id of person trying to get assignment from archive
  /// [AssignmentID] id of the assignment in the database
  @required
  Future<bool> execute(
      {required MemberID memberID, required AssignmentID assignmentID});
}

class DefaultUnarchiveAssignmentUseCase implements UnarchiveAssignmentUseCase {
  final MemberRepository _memberRepository;
  final AssignmentRepository _assignmentRepository;

  DefaultUnarchiveAssignmentUseCase(
      this._memberRepository, this._assignmentRepository);

  @override
  Future<bool> execute(
      {required MemberID memberID, required AssignmentID assignmentID}) async {
    Member? accessor = await _memberRepository.find(memberID);
    accessor ?? (throw AssignmentNotFoundError());

    Assignment? assignment = await _assignmentRepository.find(assignmentID);
    assignment ?? (throw AssignmentNotFoundError());

    if (assignment.canArchive(
        memberID: accessor.id, permissions: accessor.role.permissions)) {
      assignment.unArchive();
      return _assignmentRepository.update(assignment);
    }

    throw PermissionDeniedError(
        reason: "Insufficient Permissions to unarchive ${assignment.title}");
  }
}
