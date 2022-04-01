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
  final JoinRequestRepository _requestRepository;
  final AuthorizationRepository _authorizationRepository;
  final RoleRepository _roleRepository;

  DefaultDeleteOrganizationUseCase(
    this._organizationRepository,
    this._memberRepository,
    this._assignmentRepository,
    this._eventRepository,
    this._requestRepository,
    this._authorizationRepository,
    this._roleRepository,
  );

  @override
  Future<bool> execute(
      {required MemberID creatorID,
      required OrganizationID organizationID}) async {
    // verify creator
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
          // Failed to remove a single member
          throw FailedToRemoveError(
              forEntity: "Delete Organization Member $member");
      }

      // Remove Join Requests
      List<JoinRequest> requests =
          await _requestRepository.findAll(organizationID);
      for (JoinRequest request in requests) {
        if (!(await _requestRepository.remove(request.id)))
          // Failed to remove single join request
          throw FailedToRemoveError(
              forEntity: "Delete Organization Join Request");
      }

      // Remove all Assignments
      List<Assignment> assignments =
          await _assignmentRepository.findAll(organizationID);
      for (Assignment assignment in assignments) {
        if (!(await _assignmentRepository.remove(assignment.id)))
          // Failed to remove single assignment
          throw FailedToRemoveError(
              forEntity: "Delete Organization Assignment");
      }

      // Remove all Roles
      List<Role> roles = await _roleRepository.findAll(organizationID);
      for (Role role in roles) {
        await _roleRepository.remove(role.id);
      }

      // Remove all Authorizations
      List<Authorization> authorizations =
          await _authorizationRepository.findAll(organizationID);
      for (Authorization authorization in authorizations) {
        await _authorizationRepository.remove(authorization.id);
      }

      // TODO: Remove all Events
      // List<Event> events = await _eventRepository.findAll(organizationID);
      // for (Event event in events) {
      //   if (!(await _eventRepository.remove(event.id)))
      //     // TODO: Failed to remove single event
      //     throw FailedToRemoveError(forEntity: "Delete Organization Event");
      // }

      return true;
    } else {
      // Failed to remove organization
      throw FailedToRemoveError(forEntity: "Delete Organization $organization");
    }
  }
}
