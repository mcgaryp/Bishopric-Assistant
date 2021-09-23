import 'package:async/async.dart';

import 'organization.dart';
import 'organization_id.dart';

///
/// organization_repository.dart
/// bishopric-assistant
///
/// Created by Po. on 9/22/21
/// Copyright 2021 Po. All rights reserved.
///

/// TODO: Separate into another layer
abstract class OrganizationRepository {
  /// [find] an organization
  ///
  /// Returns an [Organization]
  Organization find(OrganizationID id);

  /// [findAll] organizations
  ///
  /// Returns a [List<Organization>]
  List<Organization> findAll();

  /// [store] organization
  ///
  /// Returns a [ValueResult] or an [ErrorResult]
  /// TODO: Change bool to enum outcomes
  bool store(Organization organization);

  /// [generateNextId]
  ///
  /// Returns a [OrganizationID]
  OrganizationID generateNextId();
}
