import 'package:models/models/organization_domain/organization_id.dart';
import 'package:models/models/organization_domain/roles/role_id.dart';
import 'package:models/shared/exceptions/id_does_not_exist_error.dart';

///
/// $FILE_NAME.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 3/18/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class DBRole {
  static const String roleIDKey = "DB Role ID";
  static const String organizationIDKey = "DB Role Organization ID";
  static const String authorizationIDKey = "DB Role Authorization ID";
  static const String nameKey = "DB Role Name";

  String? roleID;
  String? organizationID;
  String? authorizationID;
  String? name;

  DBRole({this.roleID, this.organizationID, this.authorizationID, this.name});

  DBRole.fromMap(Map<String, dynamic> map)
      : this(
          roleID: map[roleIDKey],
          organizationID: map[organizationIDKey],
          authorizationID: map[authorizationIDKey],
          name: map[nameKey],
        );

  RoleID get toRoleID {
    roleID ?? (throw IdDoesNotExistError(forObject: "DB Role ID"));
    return RoleID(roleID!);
  }

  String get toAuthorizationID {
    authorizationID ?? (throw Exception("DB Role Authorization ID is null"));
    return authorizationID!;
  }

  OrganizationID get toOrganizationID {
    organizationID ??
        (throw IdDoesNotExistError(forObject: "DB Role Organization ID"));
    return OrganizationID(organizationID!);
  }

  String get toName {
    name ?? (throw Exception("DB Role Name is null"));
    return name!;
  }

  Map<String, dynamic> get toMap => {
        roleIDKey: roleID,
        organizationIDKey: organizationID,
        authorizationIDKey: authorizationID,
        nameKey: name,
      };
}
