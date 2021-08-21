import 'package:bishop_assistant_web_test_app/database/DatabaseModel.dart';
import 'package:bishop_assistant_web_test_app/database/models/Role.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/member_cards/MemberCard.dart';
import 'package:flutter/material.dart';

///
/// Member.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/13/21
/// Copyright 2021 porter. All rights reserved.
///

class Member extends DatabaseModel {
  late String firstName;
  late String lastName;
  late String phone;
  late String email;
  late String password;
  late IconData image;
  late Role role;
  late int roleInt;
  late int security;

  Member(
      {required id,
      required this.firstName,
      required this.lastName,
      required this.phone,
      required this.email,
      this.image = Icons.person,
      required this.role,
      required this.security,
      this.password = ""})
      : super(id, "$firstName $lastName");

  Member.model(int id, String name) : super(id, name);

  Member.create({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.password,
    required this.role,
  }) : super(-1, "$firstName $lastName") {
    image = Icons.person;
    security = -1;
  }

  // region Static Members
  static Member bishopExample = Member(
      id: -1,
      firstName: "John",
      lastName: "Doe",
      phone: "(576) 398-0987",
      email: "john@doe.com",
      role: Role.bishop,
      security: 1);
  static Member counselor1Example = Member(
      id: -1,
      firstName: "Ben",
      lastName: "Dover",
      phone: "(208) 123-7895",
      email: "ben@dover.com",
      role: Role.counselor1,
      security: 2);
  static Member counselor2Example = Member(
      id: -1,
      firstName: "Jeff",
      lastName: "Bezos",
      phone: "(479) 684-9137",
      email: "jeff@amazon.com",
      role: Role.counselor2,
      security: 2);
  static Member wardClerkExample = Member(
      id: -1,
      firstName: "James",
      lastName: "Bucanon",
      phone: "(783) 167-6548",
      email: "james@western.com",
      role: Role.wardClerk,
      security: 3);
  static Member assistantWardClerkExample = Member(
      id: -1,
      firstName: "Jimmy",
      lastName: "Newtron",
      phone: "(794) 456-9321",
      email: "new@science.com",
      role: Role.assistantWardClerk,
      security: 3);
  static Member wardExecutiveSecretaryExample = Member(
      id: -1,
      firstName: "Lebron",
      lastName: "James",
      phone: "(852) 951-7531",
      email: "just@basket.net",
      role: Role.wardExecutiveSecretary,
      security: 3);
  static Member wardAssistantExecutiveSecretaryExample = Member(
      id: -1,
      firstName: "Jimmy",
      lastName: "Falon",
      phone: "(741) 963-8520",
      email: "just2funny@laugh.com",
      role: Role.assistantWardExecutiveSecretary,
      security: 3);

  static List<Member> exampleMemberList = [
    bishopExample,
    counselor1Example,
    counselor2Example,
    wardClerkExample,
    assistantWardClerkExample,
    wardExecutiveSecretaryExample,
    wardAssistantExecutiveSecretaryExample
  ];

  static List<MemberCard> exampleMemberCardList = [
    MemberCard(Member.bishopExample),
    MemberCard(Member.counselor1Example),
    MemberCard(Member.counselor2Example),
    MemberCard(Member.wardClerkExample),
    MemberCard(Member.assistantWardClerkExample),
    MemberCard(Member.wardExecutiveSecretaryExample),
    MemberCard(Member.wardAssistantExecutiveSecretaryExample)
  ];
//endregion
}

// TODO: Solve a better way of using this
extension ParseRolesToString on Role {
  String get string {
    switch (this) {
      case Role.bishop:
        return "Bishop";
      case Role.counselor1:
        return "1st Counselor";
      case Role.counselor2:
        return "2nd Counselor";
      case Role.wardClerk:
        return "Ward Clerk";
      case Role.assistantWardClerk:
        return "Assistant Ward Clerk";
      case Role.wardExecutiveSecretary:
        return "Ward Executive Secretary";
      case Role.assistantWardExecutiveSecretary:
        return "Ward Assistant Executive Secretary";
      case Role.none:
        return "N/A";
    }
  }

  static Role roleFromString(String string) {
    switch (string) {
      case "Bishop":
        return Role.bishop;
      case "1st Counselor":
        return Role.counselor1;
      case "2nd Counselor":
        return Role.counselor2;
      case "Ward Clerk":
        return Role.wardClerk;
      case "Assistant Ward Clerk":
        return Role.assistantWardClerk;
      case "Ward Executive Secretary":
        return Role.wardExecutiveSecretary;
      case "Ward Assistant Executive Secretary":
        return Role.assistantWardExecutiveSecretary;
      default:
        return Role.none;
    }
  }

  static roleFromInt(int role) {
    switch(role) {
      case 0:
        return Role.none;
      case 1:
        return Role.bishop;
      case 2:
        return Role.counselor1;
      case 3:
        return Role.counselor2;
      case 4:
        return Role.wardClerk;
      case 5:
        return Role.assistantWardClerk;
      case 6:
        return Role.wardExecutiveSecretary;
      case 7:
        return Role.assistantWardExecutiveSecretary;
    }
  }
}
