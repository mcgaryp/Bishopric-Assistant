import 'package:bishop_assistant_web_test_app/database/models/Role.dart';
import 'package:flutter/material.dart';

///
/// Member.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/13/21
/// Copyright 2021 porter. All rights reserved.
///

class Member {
  late int id = -1;
  late String firstName = "Porter";
  late String lastName = "McGary";
  late String phone = "(479) 696-1637";
  late String email = "portermcgary@gmail.com";
  late IconData image = Icons.person;
  late Role role = Role.counselor1;
  late int security;

  Member(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.phone,
      required this.email,
      this.image = Icons.person,
      required this.role,
      required this.security});

  static Member bishopExample = Member(
      id: 0,
      firstName: "John",
      lastName: "Doe",
      phone: "(576) 398-0987",
      email: "john@doe.com",
      role: Role.bishop,
      security: 1);
  static Member counselor1Example = Member(
      id: 0,
      firstName: "Ben",
      lastName: "Dover",
      phone: "(208) 123-7895",
      email: "ben@dover.com",
      role: Role.counselor1,
      security: 2);
  static Member counselor2Example = Member(
      id: 0,
      firstName: "Jeff",
      lastName: "Bezos",
      phone: "(479) 684-9137",
      email: "jeff@amazon.com",
      role: Role.counselor2,
      security: 2);
  static Member wardClerkExample = Member(
      id: 0,
      firstName: "James",
      lastName: "Bucanon",
      phone: "(783) 167-6548",
      email: "james@western.com",
      role: Role.wardClerk,
      security: 3);
  static Member assistantWardClerkExample = Member(
      id: 0,
      firstName: "Jimmy",
      lastName: "Newtron",
      phone: "(794) 456-9321",
      email: "new@science.com",
      role: Role.assistantWardClerk,
      security: 3);
  static Member wardExecutiveSecretaryExample = Member(
      id: 0,
      firstName: "Lebron",
      lastName: "James",
      phone: "(852) 951-7531",
      email: "just@basket.net",
      role: Role.wardExecutiveSecretary,
      security: 3);
  static Member wardAssistantExecutiveSecretaryExample = Member(
      id: 0,
      firstName: "Jimmy",
      lastName: "Falon",
      phone: "(741) 963-8520",
      email: "just2funny@laugh.com",
      role: Role.assistantWardExecutiveSecretary,
      security: 3);
}

extension ParseToString on Role {
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
        return "Assistant Ward Executive Secretary";
    }
  }
}
