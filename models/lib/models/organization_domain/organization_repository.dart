import 'package:models/models/organization.dart';

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
mixin OrganizationRepository {
  @required
  Future<Organization?> find(OrganizationID id);

  @required
  Future<List<Organization>> findAll();

  @required
  Future<Organization?> findByName(String name);

  @required
  Future<OrganizationID?> insert(String name);

  @required
  Future<bool> remove(OrganizationID id);

  @required
  Future<bool> update(Organization organization);
}
