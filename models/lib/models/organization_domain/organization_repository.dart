import 'package:models/models/organization.dart';
import 'package:models/shared/repository.dart';

export 'package:models/models/account_domain/account_id.dart';

///
/// organization_repository.dart
/// bishopric-assistant
///
/// Created by Po. on 9/22/21
/// Copyright 2021 Po. All rights reserved.
///

/// [OrganizationRepository] manages the access and manipulation of the
/// organization Repository
mixin OrganizationRepository
    implements Repository<Organization, OrganizationID, void> {
  @Deprecated("No more Relationships")
  Future<bool> insertRelationship(OrganizationMemberRelationship relationship);

  @Deprecated("No more Relationships")
  Future<List<OrganizationMemberRelationship>> findAllRelationships(
      OrganizationID organizationID);

  @Deprecated("No more Relationships")
  Future<bool> removeRelationship(OrganizationMemberRelationship relationship);

  Stream<List<JoinRequest>> findAllRequestsStreamed(
      OrganizationID organizationID);

  Future<List<JoinRequest>> findAllRequests(OrganizationID organizationID);

  Stream<List<Organization>> findAll();

  Stream<Organization> findStreamed(OrganizationID id);

  Future<bool> requestToJoinOrganization(JoinRequest joinRequest);

  Future<bool> removeRequestToJoinOrganization(JoinRequest request);

  Future<Organization?> findByName(String name);
}
