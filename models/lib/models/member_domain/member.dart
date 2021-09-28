import 'package:models/shared/entity.dart';

import '../organization_domain/organization_id.dart';
import '../role.dart';
import '../user.dart';
import 'member_id.dart';

///
/// member.dart
/// bishopric-assistant
///
/// Created by Po on 9/22/21
/// Copyright 2021 Po. All rights reserved.
///

/// TODO: Comments
class Member extends Entity<Member> {
  final MemberID id;
  final Role role;
  final User user;
  final OrganizationID organizationID;

  Member(
      {required this.id,
      required this.role,
      required this.user,
      required this.organizationID})
      : super(id);

  Member.newRole({required this.role, required Member member})
      : this.user = member.user,
        this.id = member.id,
        this.organizationID = member.organizationID,
        super(member.id);

  @override
  bool sameIdentityAs(Member other) {
    // TODO: implement sameIdentityAs
    throw UnimplementedError();
  }
}
