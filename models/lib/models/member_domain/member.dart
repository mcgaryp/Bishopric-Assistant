import 'package:models/models/member.dart';
import 'package:models/shared/entity.dart';

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
  final Name name;
  final OrganizationID organizationID;

  Member(
      {required this.id,
      required this.name,
      required this.role,
      required this.contact,
      required this.organizationID})
      : super(id);

  Member.newRole({required this.role, required Member member})
      : this.contact = member.contact,
        this.name = member.name,
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
