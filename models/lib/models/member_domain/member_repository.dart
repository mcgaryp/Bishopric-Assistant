import 'package:models/models/member.dart';
import 'package:models/models/organization.dart';
import 'package:models/shared/repository.dart';

import 'member.dart';
import 'member_id.dart';

///
/// member_repository.dart
/// bishopric-assistant
///
/// Created by Po on 9/23/21
/// Copyright 2021 Po. All rights reserved.
///

mixin MemberRepository implements Repository<Member, MemberID> {
  @required
  findAllMembersByOrganization(OrganizationID organizationID);
}
