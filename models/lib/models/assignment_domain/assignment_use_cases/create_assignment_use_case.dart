import 'package:models/models/assignment.dart';
import 'package:models/models/organization.dart';
import 'package:models/shared/exceptions.dart';

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
  Future<Assignment> execute(
      {required String title,
      required DateTime dueDate,
      required Assignee assignee,
      required MemberID memberID,
      required Note note});
}

class DefaultCreateAssignmentUseCase implements CreateAssignmentUseCase {
  final AssignmentRepository _assignmentRepository;
  final MemberRepository _memberRepository;

  DefaultCreateAssignmentUseCase(
      this._assignmentRepository, this._memberRepository);

  @override
  Future<Assignment> execute(
      {required String title,
      required DateTime dueDate,
      required Assignee assignee,
      required MemberID memberID,
      required Note note}) async {
    Member? member = await _memberRepository.find(memberID);

    member ?? (throw MemberNotFoundError());

    if (member.role.permissions < Permissions.Reporter) {
      throw PermissionDeniedError(
          reason: "Insufficient privilege to create assignment");
    }

    Organization? organization =
        await _memberRepository.findOrganization(memberID);

    organization ?? (throw OrganizationNotFoundError());

    List<Assignment> assignments =
        await _assignmentRepository.findAll(organization.id);

    Creator creator = Creator(
        contact: member.contact,
        name: member.name,
        id: member.id,
        permissions: member.role.permissions);

    Assignment assignment = Assignment(
      creator: creator,
      isArchived: false,
      assignee: assignee,
      isCompleted: false,
      note: note,
      title: title,
      dueDate: dueDate,
      orgID: organization.id,
    );

    if (assignments.isNotEmpty) {
      bool hasDuplicates = assignments.every((Assignment a) => assignment == a);
      if (hasDuplicates) {
        throw FailedToSaveError(
            forEntity:
                "Cannot create assignment because assignment already exists");
      }
    }

    Assignment? assignmentWithID =
        await _assignmentRepository.insert(assignment);

    assignmentWithID ??
        (throw FailedToSaveError(
            forEntity: "create_assignment_use_case Insert"));

    return assignmentWithID;
  }
}
