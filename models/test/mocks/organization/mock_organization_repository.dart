import 'package:models/models/organization.dart';

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
  Future<List<Organization>> findAll() {
    findAllFlag = true;
    return Future.value(List.filled(2, organization));
  }

  @override
  Future<Organization?> findByName(String name) {
    findByNameFlag = true;
    if (organization.name == name) return Future.value(organization);
    return Future.value(null);
  }

  @override
  Future<OrganizationID> insert(String name) {
    insertFlag = true;
    return Future.value(organization.id);
  }

  @override
  Future<bool> remove(OrganizationID i) {
    removeFlag = true;
    return Future.value(shouldSucceed);
  }

  @override
  Future<bool> update(Organization m) {
    updateFlag = true;
    return Future.value(shouldSucceed);
  }
}
