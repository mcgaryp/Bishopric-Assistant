import 'package:models/models/organization.dart';
import 'package:models/shared/exceptions/exceptions.dart';

///
/// $FILE_NAME.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 3/16/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class DBOrganization {
  static const String idKey = "Organization ID";
  static const String nameKey = "Organization Name";
  static const String creatorIDKey = "Organization Creator ID";

  String? id;
  String? name;
  String? creatorID;

  DBOrganization({this.id, this.name, this.creatorID});

  DBOrganization.fromMap(Map<String, dynamic> map)
      : this(
          id: map[idKey],
          name: map[nameKey],
          creatorID: map[creatorIDKey],
        );

  DBOrganization.fromOrganization(Organization organization)
      : this(
          id: organization.id.id,
          name: organization.name,
          creatorID: organization.creator.id.id,
        );

  DBOrganization.fromDBs(
      {required DBMember dbMember, required String? name, required String? id})
      : this(
          id: id,
          name: name,
          creatorID: dbMember.memberID,
        );

  Map<String, dynamic> get toMap => {
        idKey: id,
        nameKey: name,
        creatorIDKey: creatorID,
      };

  String get toName {
    name ?? (throw EmptyStringError(forObject: "DB Organization Name"));
    return name!;
  }

  OrganizationID get toOrganizationID {
    id ?? (throw IdDoesNotExistError(forObject: "DB Organization ID"));
    return OrganizationID(id!);
  }

  MemberID get toCreatorID {
    creatorID ??
        (throw IdDoesNotExistError(forObject: "DB Organization Creator ID"));
    return MemberID(creatorID!);
  }
}
