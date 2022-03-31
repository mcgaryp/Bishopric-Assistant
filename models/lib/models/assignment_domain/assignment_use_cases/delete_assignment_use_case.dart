import 'package:models/models/assignment.dart';
import 'package:models/models/organization.dart';
import 'package:models/shared/foundation.dart';

///
/// delete_assignment_use_case.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 2/10/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

mixin DeleteAssignmentUseCase {
  @required
  Future<bool> execute(
      {required AssignmentID assignmentID, required MemberID memberID});
}

class DefaultDeleteAssignmentUseCase implements DeleteAssignmentUseCase {
  final AssignmentRepository _assignmentRepository;
  final MemberRepository _memberRepository;

  DefaultDeleteAssignmentUseCase(
      this._assignmentRepository, this._memberRepository);

  @override
  Future<bool> execute(
      {required AssignmentID assignmentID, required MemberID memberID}) async {
    Assignment? assignment = await _assignmentRepository.find(assignmentID);
    assignment ?? (throw AssignmentNotFoundError());

    Member? accessor = await _memberRepository.find(memberID);
    accessor ?? (throw MemberNotFoundError());

    if (assignment.canView(roleID: accessor.role.id)) {
      return _assignmentRepository.remove(assignmentID);
    }

    throw PermissionDeniedError(
        reason: "Insufficient Permissions to Delete ${assignment.title}");
  }
}
