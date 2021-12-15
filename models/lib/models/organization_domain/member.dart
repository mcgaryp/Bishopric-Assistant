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
  final Name name;
  final Contact contact;
  final MemberID? _id;
  final Role role;

  Member(
      {required this.name,
      required this.contact,
      required this.role,
      MemberID? id})
      : this._id = id,
        super(id);

  Member.fromMap(MemberID id, Map<String, dynamic> map)
      : this(
          name: Name.fromMap(map),
          contact: Contact.fromMap(map),
          role: Role.fromMap(map),
          id: id,
        );

  Member.newRole({required Role role, required Member member})
      : this.role = role,
        this.name = member.name,
        this.contact = member.contact,
        this._id = member.id,
        super(member.id);

  Map<String, dynamic> get toMap {
    Map<String, dynamic> map = {};
    map.addAll(name.toMap);
    map.addAll(contact.toMap);
    map.addAll(role.toMap);
    return map;
  }

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
