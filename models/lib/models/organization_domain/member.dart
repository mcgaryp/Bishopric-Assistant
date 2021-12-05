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

/// [Member] represents the member in an organization
class Member extends Entity<Member> {
  final Name name;
  final Contact contact;
  final MemberID memberID;
  final Role role;

  Member(
      {required this.name,
      required this.contact,
      required this.role,
      required this.memberID})
      : super(memberID);

  Member.fromMap(MemberID id, Map<String, dynamic> map)
      : this(
          name: Name(first: map["first"], last: map["last"]),
          contact: Contact(email: map["email"], phone: map["phone"]),
          role: Role(PermissionsExtension.fromString(map["character"]),
              anonymous: map["anonymous"]),
          memberID: id,
        );

  Member.newRole({required Role role, required Member member})
      : this.role = role,
        this.name = member.name,
        this.contact = member.contact,
        this.memberID = member.memberID,
        super(member.memberID);

  Map<String, dynamic> get toMap {
    Map<String, dynamic> map = {};
    map.addAll(name.toMap);
    map.addAll(contact.toMap);
    map.addAll(role.toMap);
    return map;
  }

  @override
  bool sameIdentityAs(Member other) {
    return this.memberID == other.memberID;
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != Member) return false;
    return sameIdentityAs(other as Member);
  }

  @override
  String toString() {
    return "${name.name}\n $contact, $role";
  }
}
