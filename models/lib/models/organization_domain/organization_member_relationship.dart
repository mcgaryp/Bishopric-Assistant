import 'package:models/models/account.dart';
import 'package:models/models/assignment.dart';
import 'package:models/models/organization_domain/member_id.dart';
import 'package:models/models/organization_domain/organization_id.dart';
import 'package:models/shared/exceptions/exceptions.dart';
import 'package:models/shared/uuid.dart';

///
/// organization_member_relationship.dart
/// bishopric-assistant
///
/// Created by Po on 1/24/22
/// Copyright 2022 Po. All rights reserved.
///

@Deprecated("There are no more relationships!")
class OrganizationMemberRelationship {
  static const String orgIdKey = "OrganizationID";
  static const String memberIdKey = "MemberID";
  static const String accountIdKey = "AccountID";
  static const String idKey = "Organization Member Relationship ID";

  final OrganizationID organizationID;
  final MemberID memberID;
  final AccountID accountID;
  final RelationshipID? _id;

  OrganizationMemberRelationship({
    required this.accountID,
    required this.organizationID,
    required this.memberID,
    RelationshipID? id,
  }) : this._id = id;

  OrganizationMemberRelationship.fromMap(Map<String, dynamic> map)
      : this(
          accountID: AccountID(map[accountIdKey]),
          organizationID: OrganizationID(map[orgIdKey]),
          memberID: MemberID(map[memberIdKey]),
          id: RelationshipID(map[idKey]),
        );

  Map<String, dynamic> get toMap => {
        orgIdKey: organizationID.id,
        memberIdKey: memberID.id,
        accountIdKey: accountID.id,
        idKey: _id,
      };

  UUID get id {
    if (_id == null)
      throw IdDoesNotExistError(forObject: "Organization Member Relationship");
    return _id!;
  }
}
