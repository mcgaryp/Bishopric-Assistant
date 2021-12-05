import 'package:models/models/organization.dart';
import 'package:models/shared/repository.dart';

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
  Future<bool> addMember(Member member);

  Future<bool> insertRelationship(
      OrganizationID organizationID, MemberID memberID);
}
