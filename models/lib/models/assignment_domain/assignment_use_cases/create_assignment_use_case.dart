import 'package:models/models/assignment.dart';
import 'package:models/models/organization.dart';
import 'package:models/shared/exceptions/exceptions.dart';

///
/// create_assignment_use_case.dart
/// bishopric-assistant
///
/// Created by Joshua Bee on 1/21/22
/// Copyright 2022 Joshua Bee. All rights reserved.
///

mixin CreateAssignmentUseCase {
  /// Creates a new assignment
  ///
  /// [creatorId] id of the creator of the assignment
  /// [title] given to the assignment
  /// [dueDate] of the assignment
  /// [assignee] who is assigned to this assignment
  /// [visiblePermissions] who can see the assignment
  /// [note] for more detail about the assignment
  @required
  Future<bool> execute({
    required String title,
    required DateTime dueDate,
    required String note,
    required bool editable,
    required bool reassignable,
    required Role assignee,
    required List<Role> viewers,
    required MemberID memberID,
  });
}

class DefaultCreateAssignmentUseCase implements CreateAssignmentUseCase {
  final AssignmentRepository _assignmentRepository;
  final MemberRepository _memberRepository;

  DefaultCreateAssignmentUseCase(
      this._assignmentRepository, this._memberRepository);

  @override
  Future<bool> execute({
    required String title,
    required DateTime dueDate,
    required String note,
    required bool editable,
    required bool reassignable,
    required Role assignee,
    required List<Role> viewers,
    required MemberID memberID,
  }) async {
    // Verify Creator is in organization
    Member? creator = await _memberRepository.find(memberID);
    creator ?? (throw MemberNotFoundError());

    // Find Organization
    Organization? organization =
        await _memberRepository.findOrganization(memberID);
    organization ?? (throw OrganizationNotFoundError());

    // TODO: Check organization settings on creation
    // if (member.role.authorization.rank < 0) {
    //   throw PermissionDeniedError(
    //       reason: "Insufficient privilege to create assignment");
    // }

    // Create Assignment
    Assignment assignment = Assignment(
      creator: creator.role,
      isArchived: false,
      assignee: assignee,
      isCompleted: false,
      note: note,
      title: title,
      dueDate: dueDate,
      orgID: organization.id,
      reassignable: reassignable,
      viewers: viewers,
      editable: editable,
    );

    // Insert Assignment
    if (await _assignmentRepository.insert(assignment)) return true;

    // Notify of failure
    throw FailedToSaveError(reason: "create_assignment_use_case Insert");
  }
}
