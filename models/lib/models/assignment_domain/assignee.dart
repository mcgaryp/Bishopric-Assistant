import 'package:models/models/account.dart';
import 'package:models/models/assignment.dart';
import 'package:models/models/organization.dart';

///
/// assignee.dart
/// bishopric-assistant
///
/// Created by Joshua Bee on 1/18/22
/// Copyright 2022 Joshua Bee. All rights reserved.
///
class Assignee extends Person {
  static final String nameKey = "Assignee Name";
  static final String contactKey = "Assignee Contact";
  static final String idKey = "Assignee ID";
  static final String permissionsKey = "Assignee Permissions";

  Assignee(
      {required Contact contact,
      required Name name,
      required MemberID id,
      required Authorization authorization})
      : super(contact: contact, name: name, id: id, authorization: authorization);

  Assignee.fromMap(Map<String, dynamic> map)
      : this(
            contact: Contact.fromMap(map[contactKey]),
            name: Name.fromMap(map[nameKey]),
            id: MemberID(map[idKey]),
            authorization: Authorization.fromMap(map[permissionsKey]));

  Assignee.fromMember(Member member)
      : this(
          contact: member.contact,
          name: member.name,
          id: member.id,
          authorization: member.role.authorization,
        );

  @override
  bool sameValueAs(Person other) {
    return other.name == this.name &&
        other.id == this.id &&
        other.authorization == this.authorization;
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != Assignee) return false;
    return sameValueAs(other as Assignee);
  }

  @override
  Map<String, dynamic> get toMap => {
        nameKey: name.toMap,
        contactKey: contact.toMap,
        idKey: id.id,
        permissionsKey: authorization.toMap,
      };
}
