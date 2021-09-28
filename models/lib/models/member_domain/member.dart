import 'package:models/models/accounts/contact.dart';
import 'package:models/models/accounts/role.dart';
import 'package:models/shared/entity.dart';

import '../organization_domain/organization_id.dart';
import 'member_id.dart';

///
/// member.dart
/// bishopric-assistant
///
/// Created by Po on 9/22/21
/// Copyright 2021 Po. All rights reserved.
///

/// [Member] of an organization
class Member extends Entity<Member> {
  final MemberID id;
  final Role role;
  final Contact contact;
  final OrganizationID organizationID;

  Member(
      {required this.id,
      required this.role,
      required this.contact,
      required this.organizationID})
      : super(id);

  Member.newRole({required this.role, required Member member})
      : this.contact = member.contact,
        this.id = member.id,
        this.organizationID = member.organizationID,
        super(member.id);

  @override
  bool sameIdentityAs(Member other) {
    return other.id == this.id;
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != Member) return false;
    return sameIdentityAs(other as Member);
  }
}
