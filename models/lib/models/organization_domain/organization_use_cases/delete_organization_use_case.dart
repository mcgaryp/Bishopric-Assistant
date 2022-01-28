import 'package:models/models/assignment.dart';
import 'package:models/models/event.dart';
import 'package:models/models/organization.dart';
import 'package:models/shared/foundation.dart';

///
/// delete_organization.dart
///
///
/// Created by Porter McGary on 12/2/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

mixin DeleteOrganizationUseCase {
  /// Removes an organization and its members
  ///
  /// [creatorID] id of the creator who is the only one with access to remove
  /// the organization
  /// [organizationID] of the organization being removed
  /// Returns true if successful else returns false
  @required
  Future<bool> execute(
      {required MemberID creatorID, required OrganizationID organizationID});
}

class DefaultDeleteOrganizationUseCase implements DeleteOrganizationUseCase {
  final OrganizationRepository _organizationRepository;
  final MemberRepository _memberRepository;
  final AssignmentRepository _assignmentRepository;
  final EventRepository _eventRepository;

  DefaultDeleteOrganizationUseCase(
      this._organizationRepository,
      this._memberRepository,
      this._assignmentRepository,
      this._eventRepository);

  @override
  Future<bool> execute(
      {required MemberID creatorID,
      required OrganizationID organizationID}) async {
    Member? creator = await _memberRepository.find(creatorID);
    if (creator == null) throw MemberNotFoundError();
    Organization? organization =
        await _organizationRepository.find(organizationID);
    if (organization == null) throw OrganizationNotFoundError();
    if (organization.creator != creator)
      throw PermissionDeniedError(
          reason: "Only creators can delete organizations");

    // Remove Organization
    if (await _organizationRepository.remove(organizationID)) {
      // Remove members
      List<Member> members = await _memberRepository.findAll(organizationID);
      for (Member member in members) {
        if (!(await _memberRepository.remove(member.id)))
          // TODO: Failed to remove a single member
          throw FailedToRemoveError(
              forEntity: "Delete Organization Member $member");
      }

      // Remove member account organization relationships
      List<OrganizationMemberRelationship> relationships =
          await _organizationRepository.findAllRelationships(organizationID);

      for (OrganizationMemberRelationship relationship in relationships) {
        if (!(await _organizationRepository.removeRelationship(relationship)))
          // TODO: Failed to remove single relationship
          throw FailedToRemoveError(
              forEntity: "Delete Organization Relationship $relationship");
      }

      // Remove Join Requests
      List<JoinRequest> requests =
          await _organizationRepository.findAllRequests(organizationID);
      for (JoinRequest request in requests) {
        if (!(await _organizationRepository
            .removeRequestToJoinOrganization(request)))
          // TODO: Failed to remove single join request
          throw FailedToRemoveError(
              forEntity: "Delete Organization Join Request");
      }

      // TODO: Remove all Assignments
      // List<Assignment> assignments = await _assignmentRepository.findAll(organizationID);
      // for (Assignment assignment in assignments) {
      //   if (!(await _assignmentRepository.remove(assignment.id)))
      //     // TODO: Failed to remove single assignment
      //     throw FailedToRemoveError(forEntity: "Delete Organization Assignment");
      //   if (!(await _assignmentRepository.removeRelationship(assignment.id)))
      //     // TODO: Failed to remove single assignment relationship
      //     throw FailedToRemoveError(forEntity: "Delete Organization Assignment Relationship");
      // }

      // TODO: Remove all Events
      // List<Event> events = await _eventRepository.findAll(organizationID);
      // for (Event event in events) {
      //   if (!(await _eventRepository.remove(event.id)))
      //     // TODO: Failed to remove single event
      //     throw FailedToRemoveError(forEntity: "Delete Organization Event");
      //   if (!(await _eventRepository.removeRelationship(event.id)))
      //     // TODO: Failed to remove single event relationship
      //     throw FailedToRemoveError(forEntity: "Delete Organization Event Relationship");
      // }

      return true;
    } else {
      // TODO: Failed to remove organization
      throw FailedToRemoveError(forEntity: "Delete Organization $organization");
    }
  }
}
