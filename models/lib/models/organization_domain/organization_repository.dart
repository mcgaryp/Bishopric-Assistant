import 'package:models/models/member.dart';
import 'package:models/models/member_domain/member_id.dart';
import 'package:models/shared/repository.dart';

import 'organization.dart';
import 'organization_id.dart';

///
/// organization_repository.dart
/// bishopric-assistant
///
/// Created by Po. on 9/22/21
/// Copyright 2021 Po. All rights reserved.
///

/// TODO: Implement Event, Refer to [ReadMe.md](models/README.md)
/// TODO: Comment
mixin OrganizationRepository
    implements Repository<Organization, OrganizationID, void> {
  @required
  Future<Member?> findMember(MemberID id);
}
