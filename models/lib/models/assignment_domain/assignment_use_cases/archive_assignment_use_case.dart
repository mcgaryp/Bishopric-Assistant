import 'package:models/models/assignment.dart';
import 'package:models/models/organization.dart';
import 'package:models/shared/exceptions/exceptions.dart';

///
/// send_assignment_to_archive_use_case.dart
/// bishopric-assistant
///
/// Created by Joshua Bee on 1/21/22
/// Copyright 2022 Joshua Bee. All rights reserved.
///

mixin ArchiveAssignmentUseCase {
  /// Sends an assignment to the archive
  ///
  /// [memberID] id of the person trying to send assignment to archive
  /// [AssignmentID] id of the assignment in the database
  @required
  Future<bool> execute(
      {required MemberID memberID, required AssignmentID assignmentID});
}

class DefaultArchiveAssignmentUseCase implements ArchiveAssignmentUseCase {
  final MemberRepository _memberRepository;
  final AssignmentRepository _assignmentRepository;

  DefaultArchiveAssignmentUseCase(
      this._memberRepository, this._assignmentRepository);

  @override
  Future<bool> execute(
      {required MemberID memberID, required AssignmentID assignmentID}) async {
    // Get member
    Member? accessor = await _memberRepository.find(memberID);
    accessor ?? (throw MemberNotFoundError());

    // Find the assignment
    Assignment? assignment = await _assignmentRepository.find(assignmentID);
    assignment ?? (throw AssignmentNotFoundError());

    // Check member permissions
    if (assignment.canArchive(roleID: accessor.role.id)) {
      assignment.archive();
      return _assignmentRepository.update(assignment);
    }

    throw PermissionDeniedError(
        reason: "Insufficient permissions to archive ${assignment.title}");
  }
}
