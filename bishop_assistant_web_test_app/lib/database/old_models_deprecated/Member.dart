import 'package:bishop_assistant_web_test_app/database/FirestoreDocument.dart';
import 'package:bishop_assistant_web_test_app/database/firestore_helper.dart';
import 'package:bishop_assistant_web_test_app/database/old_models_deprecated/Role.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/member_cards/member_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

///
/// Member.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/13/21
/// Copyright 2021 porter. All rights reserved.
///

@Deprecated("")
class OldMember extends FirestoreDocument {
  static const String emailPath = "email";
  static const String firstNamePath = "first_name";
  static const String lastNamePath = "last_name";
  static const String passwordPath = "password";
  static const String phonePath = "phone";
  static const String roleIdPath = "role_id";

  late String firstName;
  late String lastName;
  late String phone;
  late String email;
  late String password;
  late IconData image;
  late OldRole role;

  OldMember(
      {required id,
      required this.firstName,
      required this.lastName,
      required this.phone,
      required this.email,
      this.image = Icons.person,
      required this.role,
      this.password = ""})
      : super(id, "$firstName $lastName", {
          FirestoreDocument.namePath: "$firstName $lastName",
          OldMember.firstNamePath: firstName,
          OldMember.lastNamePath: lastName,
          OldMember.phonePath: phone,
          OldMember.emailPath: email,
          OldMember.roleIdPath: role.index,
          OldMember.passwordPath: password
        });

  OldMember.instance() : super(-1, "", {});

  // @Deprecated("Use Member")
  OldMember.create({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.password,
    required this.role,
  }) : super(-1, "$firstName $lastName", {
          FirestoreDocument.namePath: "$firstName $lastName",
          OldMember.firstNamePath: firstName,
          OldMember.lastNamePath: lastName,
          OldMember.phonePath: phone,
          OldMember.emailPath: email,
          OldMember.roleIdPath: role.index,
          OldMember.passwordPath: password
        }) {
    image = Icons.person;
  }

  // region Static Members
  static OldMember bishopExample = OldMember(
      id: -1,
      firstName: "John",
      lastName: "Doe",
      phone: "(576) 398-0987",
      email: "john@doe.com",
      role: OldRole.bishop);
  static OldMember counselor1Example = OldMember(
      id: -1,
      firstName: "Ben",
      lastName: "Dover",
      phone: "(208) 123-7895",
      email: "ben@dover.com",
      role: OldRole.counselor1);
  static OldMember counselor2Example = OldMember(
      id: -1,
      firstName: "Jeff",
      lastName: "Bezos",
      phone: "(479) 684-9137",
      email: "jeff@amazon.com",
      role: OldRole.counselor2);
  static OldMember wardClerkExample = OldMember(
      id: -1,
      firstName: "James",
      lastName: "Bucanon",
      phone: "(783) 167-6548",
      email: "james@western.com",
      role: OldRole.wardClerk);
  static OldMember assistantWardClerkExample = OldMember(
      id: -1,
      firstName: "Jimmy",
      lastName: "Newtron",
      phone: "(794) 456-9321",
      email: "new@science.com",
      role: OldRole.assistantWardClerk);
  static OldMember wardExecutiveSecretaryExample = OldMember(
      id: -1,
      firstName: "Lebron",
      lastName: "James",
      phone: "(852) 951-7531",
      email: "just@basket.net",
      role: OldRole.wardExecutiveSecretary);
  static OldMember wardAssistantExecutiveSecretaryExample = OldMember(
      id: -1,
      firstName: "Jimmy",
      lastName: "Falon",
      phone: "(741) 963-8520",
      email: "just2funny@laugh.com",
      role: OldRole.assistantWardExecutiveSecretary);

  static List<OldMember> exampleMemberList = [
    bishopExample,
    counselor1Example,
    counselor2Example,
    wardClerkExample,
    assistantWardClerkExample,
    wardExecutiveSecretaryExample,
    wardAssistantExecutiveSecretaryExample
  ];

  static List<MemberCard> exampleMemberCardList = [
    MemberCard(OldMember.bishopExample),
    MemberCard(OldMember.counselor1Example),
    MemberCard(OldMember.counselor2Example),
    MemberCard(OldMember.wardClerkExample),
    MemberCard(OldMember.assistantWardClerkExample),
    MemberCard(OldMember.wardExecutiveSecretaryExample),
    MemberCard(OldMember.wardAssistantExecutiveSecretaryExample)
  ];

  static Future<OldMember> find(int memberID) async {
    DocumentSnapshot memberData =
        await OldFirestoreHelper.getDocument(Collections.members, memberID);
    return OldMember(
        id: memberID,
        firstName: memberData[firstNamePath],
        lastName: memberData[lastNamePath],
        phone: memberData[phonePath],
        email: memberData[emailPath],
        role: OldRole.values[memberData[roleIdPath]],
        password: memberData[passwordPath]);
  }
//endregion
}

extension ParseRolesToString on OldRole {
  String get string {
    switch (this) {
      case OldRole.bishop:
        return "Bishop";
      case OldRole.counselor1:
        return "1st Counselor";
      case OldRole.counselor2:
        return "2nd Counselor";
      case OldRole.wardClerk:
        return "Ward Clerk";
      case OldRole.assistantWardClerk:
        return "Assistant Ward Clerk";
      case OldRole.wardExecutiveSecretary:
        return "Ward Executive Secretary";
      case OldRole.assistantWardExecutiveSecretary:
        return "Ward Assistant Executive Secretary";
      case OldRole.none:
        return "N/A";
    }
  }

  static roleFromInt(int role) {
    switch (role) {
      case 0:
        return OldRole.none;
      case 1:
        return OldRole.bishop;
      case 2:
        return OldRole.counselor1;
      case 3:
        return OldRole.counselor2;
      case 4:
        return OldRole.wardClerk;
      case 5:
        return OldRole.assistantWardClerk;
      case 6:
        return OldRole.wardExecutiveSecretary;
      case 7:
        return OldRole.assistantWardExecutiveSecretary;
    }
  }
}
