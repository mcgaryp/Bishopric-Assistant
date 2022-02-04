import 'package:models/models/assignment.dart';
import 'package:models/models/organization.dart';
import 'package:models/shared/exceptions.dart';

///
/// send_assignment_to_archive_use_case.dart
/// bishopric-assistant
///
/// Created by Joshua Bee on 1/21/22
/// Copyright 2022 Joshua Bee. All rights reserved.
///

mixin SendAssignmentToArchiveUseCase {
  /// Sends an assignment to the archive
  ///
  /// [memberID] id of the person trying to send assignment to archive
  /// [AssignmentID] id of the assignment in the database
  @required
  Future<bool> execute(
      {required MemberID memberID, required AssignmentID assignmentID});
}

class DefaultSendAssignmentToArchiveUseCase
    implements SendAssignmentToArchiveUseCase {
  final MemberRepository _memberRepository;
  final AssignmentRepository _assignmentRepository;

  DefaultSendAssignmentToArchiveUseCase(
      this._memberRepository, this._assignmentRepository);

  @override
  Future<bool> execute(
      {required MemberID memberID, required AssignmentID assignmentID}) async {
    // get member
    Member? accessor = await _memberRepository.find(memberID);
    accessor ?? (throw MemberNotFoundError());

    // find the assignment
    Assignment? assignment = await _assignmentRepository.find(assignmentID);
    assignment ?? (throw AssignmentNotFoundError());

    // check member permissions
    if (accessor.role.permissions <= assignment.visiblePermissions)
      throw PermissionDeniedError(
          reason:
              "Accessor does not have rights to send assignment to archive");

    // archive the assignment
    assignment.archive();

    // notify
    return true;
  }
}
