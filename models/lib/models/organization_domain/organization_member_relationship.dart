import 'package:models/models/account.dart';
import 'package:models/models/organization_domain/member_id.dart';
import 'package:models/models/organization_domain/organization_id.dart';

///
/// organization_member_relationship.dart
/// bishopric-assistant
///
/// Created by Po on 1/24/22
/// Copyright 2022 Po. All rights reserved.
///

class OrganizationMemberRelationship {
  static const String orgIdKey = "OrganizationID";
  static const String memberIdKey = "MemberID";
  static const String accountIdKey = "AccountID";

  final OrganizationID organizationID;
  final MemberID memberID;
  final AccountID accountID;

  OrganizationMemberRelationship(
      {required this.accountID,
      required this.organizationID,
      required this.memberID});

  OrganizationMemberRelationship.fromMap(Map<String, dynamic> map)
      : this(
          accountID: AccountID(map[accountIdKey]),
          organizationID: OrganizationID(map[orgIdKey]),
          memberID: MemberID(map[memberIdKey]),
        );

  Map<String, dynamic> get toMap => {
        orgIdKey: organizationID.id,
        memberIdKey: memberID.id,
        accountIdKey: accountID.id,
      };
}
