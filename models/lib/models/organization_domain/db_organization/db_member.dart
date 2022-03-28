import 'package:models/models/organization.dart';
import 'package:models/shared/exceptions/exceptions.dart';

///
/// $FILE_NAME.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 3/16/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class DBMember {
  static const String nameIDKey = "Member Name ID";
  static const String organizationIDKey = "Member Organization ID";
  static const String memberIDKey = "Member ID";
  static const String accountIDKey = "Member Account ID";
  static const String roleIDKey = "Member Role ID";
  static const String contactIDKey = "Member Contact ID";

  String? nameID;
  String? organizationID;
  String? memberID;
  String? accountID;
  String? roleID;
  String? contactID;

  DBMember({
    this.nameID,
    this.contactID,
    this.accountID,
    this.organizationID,
    this.memberID,
    this.roleID,
  });

  DBMember.fromMap(Map<String, dynamic> map)
      : this(
          nameID: map[nameIDKey],
          contactID: map[contactIDKey],
          accountID: map[accountIDKey],
          organizationID: map[organizationIDKey],
          memberID: map[memberIDKey],
          roleID: map[roleIDKey],
        );

  Map<String, dynamic> get toMap => {
        nameIDKey: nameID,
        contactIDKey: contactID,
        accountIDKey: accountID,
        organizationIDKey: organizationID,
        memberIDKey: memberID,
        roleIDKey: roleID,
      };

  MemberID get toMemberID {
    memberID ?? (throw IdDoesNotExistError(forObject: "DB Member ID"));
    return MemberID(memberID!);
  }

  AccountID get toAccountID {
    accountID ?? (throw IdDoesNotExistError(forObject: "DB Member Account ID"));
    return AccountID(accountID!);
  }

  OrganizationID get toOrganizationID {
    organizationID ?? (throw IdDoesNotExistError(forObject: "DB Member Organization ID"));
    return OrganizationID(organizationID!);
  }

  AccountID get toContactID {
    contactID ?? (throw IdDoesNotExistError(forObject: "DB Member Contact ID"));
    return AccountID(contactID!);
  }

  AccountID get toNameID {
    nameID ?? (throw IdDoesNotExistError(forObject: "DB Member Name ID"));
    return AccountID(nameID!);
  }

  RoleID get toRoleID {
    roleID ?? (throw IdDoesNotExistError(forObject: "DB Member Role ID"));
    return RoleID(roleID!);
  }

  @override
  String toString() {
    return toMap.toString();
  }
}
