import 'package:models/models/organization.dart';
import 'package:models/shared/exceptions/exceptions.dart';

///
/// $FILE_NAME.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 3/18/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class DBAuthorization {
  static const String rankKey = "DB Authorization Rank";
  static const String nameKey = "DB Authorization Name";
  static const String orgIDKey = "DB Authorization Organization";
  static const String idKey = "DB Authorization ID";

  String? id;
  String? name;
  String? orgID;
  int? rank;

  DBAuthorization({this.rank, this.name, this.orgID, this.id});

  DBAuthorization.fromMap(Map<String, dynamic> map)
      : this(
          rank: map[rankKey],
          name: map[nameKey],
          orgID: map[orgIDKey],
          id: map[idKey],
        );

  DBAuthorization.fromAuthorization(
      Authorization auth, OrganizationID organizationID)
      : this(
          rank: auth.rank,
          name: auth.name,
          orgID: organizationID.id,
        );

  Authorization get toAuthorization {
    if (name == null || rank == null) {
      throw Exception(
          "Unable to convert to Authorization: name => $name, rank => $rank");
    }
    return Authorization(name: name!, rank: rank!, id: toAuthID);
  }

  Map<String, dynamic> get toMap => {
        rankKey: rank,
        nameKey: name,
        orgIDKey: orgID,
        idKey: id,
      };

  AuthorizationID get toAuthID {
    id ?? (throw IdDoesNotExistError(forObject: "DB Authorization"));
    return AuthorizationID(id!);
  }
}
