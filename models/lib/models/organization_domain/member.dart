import 'package:models/models/account.dart';
import 'package:models/models/organization.dart';
import 'package:models/shared/domain_driven_design/entity.dart';
import 'package:models/shared/exceptions.dart';

///
/// member.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 11/5/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

/// [Member] represents the member in an organization
class Member extends Entity<Member> {
  static const String nameKey = "Member Name";
  static const String contactKey = "Member Contact";
  static const String idKey = "Member ID";
  static const String roleKey = "Member Role";

  final Name name;
  final Contact contact;
  final MemberID? _id;
  Role role;

  Member(
      {required this.name,
      required this.contact,
      required this.role,
      MemberID? id})
      : this._id = id,
        super(id);

  Member.fromMap(Map<String, dynamic> map)
      : this(
          name: Name.fromMap(map[nameKey]),
          contact: Contact.fromMap(map[contactKey]),
          role: Role.fromMap(map[roleKey]),
          id: MemberID(map[idKey]),
        );

  Map<String, dynamic> get toMap => {
        nameKey: name.toMap,
        contactKey: contact.toMap,
        roleKey: role.toMap,
        idKey: _id?.id,
      };

  MemberID get id {
    if (_id == null)
      throw IdDoesNotExistError(forObject: "Member");
    else
      return _id!;
  }

  @override
  bool sameIdentityAs(Member other) {
    return this.id == other.id;
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != Member) return false;
    return sameIdentityAs(other as Member);
  }

  @override
  String toString() {
    return "${name.fullName}\n $contact, $role";
  }
}
