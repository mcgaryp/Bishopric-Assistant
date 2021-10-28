import 'package:models/models/member.dart';
import 'package:models/models/organization.dart';
import 'package:models/shared/repository.dart';

///
/// member_repository.dart
/// bishopric-assistant
///
/// Created by Po on 9/23/21
/// Copyright 2021 Po. All rights reserved.
///

/// TODO: Implement MemberRepository, Refer to [ReadMe.md](old_models_deprecated/README.md)
/// TODO: Comments
mixin MemberRepository implements Repository<Member, MemberID, OrganizationID> {
  @required
  Future<List<Member>?> findAllMembersByOrganization(
      OrganizationID organizationID);
}
