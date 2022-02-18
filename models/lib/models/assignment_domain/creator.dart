import 'package:models/models/account.dart';
import 'package:models/models/assignment_domain/person.dart';
import 'package:models/models/organization_domain/member.dart';
import 'package:models/models/organization_domain/member_id.dart';
import 'package:models/models/organization_domain/permissions.dart';

///
/// creator.dart
/// bishopric-assistant
///
/// Created by Joshua Bee on 1/18/22
/// Copyright 2022 Joshua Bee. All rights reserved.
///
class Creator extends Person {
  static final String nameKey = "Creator Name";
  static final String contactKey = "Creator Contact";
  static final String idKey = "Creator ID";
  static final String permissionsKey = "Creator Permissions";

  Creator(
      {required Contact contact,
      required Name name,
      required MemberID id,
      required Permissions permissions})
      : super(contact: contact, name: name, id: id, permissions: permissions);

  Creator.fromMap(Map<String, dynamic> map)
      : this(
            contact: Contact.fromMap(map[contactKey]),
            name: Name.fromMap(map[nameKey]),
            id: MemberID(map[idKey]),
            permissions: PermissionsExtension.fromString(map[permissionsKey]));

  Creator.fromMember(Member member)
      : this(
          contact: member.contact,
          name: member.name,
          id: member.id,
          permissions: member.role.permissions,
        );

  @override
  bool sameValueAs(Person other) {
    return other.contact == this.contact &&
        other.name == this.name &&
        other.id == this.id &&
        other.permissions == this.permissions;
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != Creator) return false;
    return sameValueAs(other as Creator);
  }

  @override
  Map<String, dynamic> get toMap => {
        nameKey: name.toMap,
        contactKey: contact.toMap,
        idKey: id.id,
        permissionsKey: permissions.string,
      };
}
