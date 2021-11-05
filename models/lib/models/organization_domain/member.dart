import 'package:models/models/account.dart';
import 'package:models/models/organization.dart';
import 'package:models/shared/domain_driven_design/entity.dart';

///
/// member.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 11/5/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class Member extends Entity<Member> {
  final Name name;
  final Contact contact;
  // final AccountID accountID;
  final MemberID memberID;
  final OrganizationID organizationID;
  final Role role;

  Member(
      {required this.name,
      required this.contact,
      // required this.accountID,
      required this.memberID,
      required this.role,
      required this.organizationID})
      : super(memberID);

  Member.newRole({required Role role, required Member member})
      : this.role = role,
        this.name = member.name,
        this.contact = member.contact,
        // this.accountID = member.accountID,
        this.memberID = member.memberID,
        this.organizationID = member.organizationID,
        super(member.memberID);

  @override
  bool sameIdentityAs(Member other) {
    // TODO: implement sameIdentityAs
    throw UnimplementedError();
  }

  @override
  bool operator ==(Object other) {
    // TODO: implement ==
    return super == other;
  }
}
