import '../organization_domain/organization_id.dart';
import '../role_domain/role.dart';
import '../user_domain/user.dart';

///
/// member.dart
/// bishopric-assistant
///
/// Created by Po on 9/22/21
/// Copyright 2021 Po. All rights reserved.
///

class Member {
  final Role role;
  final User user;
  final OrganizationID organizationID;

  Member(
      {required this.role, required this.user, required this.organizationID});

  Member.newRole({required this.role, required Member member})
      : this.user = member.user,
        this.organizationID = member.organizationID;
}
