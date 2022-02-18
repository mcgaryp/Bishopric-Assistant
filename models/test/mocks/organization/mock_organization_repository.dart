import 'package:models/models/organization.dart';

import 'mock_join_request.dart';
import 'mock_organization.dart';

///
/// mock_organization_repository.dart
/// bishopric-assistant
///
/// Created by Joshua Bee on 2/2/22
/// Copyright 2022 Joshua Bee. All rights reserved.
///

class MockOrganizationRepository implements OrganizationRepository {
  bool findFlag = false;
  bool findAllFlag = false;
  bool findAllRelationshipsFlag = false;
  bool findAllRequestsFlag = false;
  bool findAllRequestsStreamedFlag = false;
  bool findByNameFlag = false;
  bool findStreamedFlag = false;
  bool insertFlag = false;
  bool insertRelationshipFlag = false;
  bool removeFlag = false;
  bool removeRelationshipFlag = false;
  bool removeRequestToJoinOrganizationFlag = false;
  bool requestToJoinOrganizationFlag = false;
  bool updateFlag = false;

  final Organization organization;
  final bool shouldSucceed;

  MockOrganizationRepository(
      {Organization? organization, this.shouldSucceed = true})
      : this.organization = organization ??
            MockOrganization(id: MockOrganizationID().id).organization;

  @override
  Future<Organization?> find(OrganizationID i) {
    findFlag = true;
    if (organization.id == i) return Future.value(organization);
    return Future.value(null);
  }

  @override
  Stream<List<Organization>> findAll() {
    findAllFlag = true;
    return Stream.value(List.filled(2, organization));
  }

  @override
  Future<List<OrganizationMemberRelationship>> findAllRelationships(
      OrganizationID organizationID) {
    findAllRelationshipsFlag = true;
    return Future.value(
        List.filled(2, MockOrganization.mockMemberRelationship));
  }

  @override
  Future<List<JoinRequest>> findAllRequests(OrganizationID organizationID) {
    findAllRequestsFlag = true;
    return Future.value(List.filled(2, MockJointRequest().request));
  }

  @override
  Stream<List<JoinRequest>> findAllRequestsStreamed(
      OrganizationID organizationID) {
    findAllRequestsStreamedFlag = true;
    return Stream.value(List.filled(2, MockJointRequest().request));
  }

  @override
  Future<Organization?> findByName(String name) {
    findByNameFlag = true;
    if (organization.name == name) return Future.value(organization);
    return Future.value(null);
  }

  @override
  Stream<Organization> findStreamed(OrganizationID id) {
    findStreamedFlag = true;
    return Stream.value(organization);
  }

  @override
  Future<Organization?> insert(Organization m) {
    insertFlag = true;
    if (shouldSucceed) return Future.value(organization);
    return Future.value(null);
  }

  @override
  Future<bool> insertRelationship(OrganizationMemberRelationship relationship) {
    insertRelationshipFlag = true;
    return Future.value(shouldSucceed);
  }

  @override
  Future<bool> remove(OrganizationID i) {
    removeFlag = true;
    return Future.value(shouldSucceed);
  }

  @override
  Future<bool> removeRelationship(OrganizationMemberRelationship relationship) {
    removeRelationshipFlag = true;
    return Future.value(shouldSucceed);
  }

  @override
  Future<bool> removeRequestToJoinOrganization(JoinRequest request) {
    removeRequestToJoinOrganizationFlag = true;
    return Future.value(shouldSucceed);
  }

  @override
  Future<bool> requestToJoinOrganization(JoinRequest joinRequest) {
    requestToJoinOrganizationFlag = true;
    return Future.value(shouldSucceed);
  }

  @override
  Future<bool> update(Organization m) {
    updateFlag = true;
    return Future.value(shouldSucceed);
  }
}
