import 'package:bishop_assistant_web_test_app/database/Role.dart';
import 'package:flutter/material.dart';

///
/// Member.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/13/21
/// Copyright 2021 porter. All rights reserved.
///

class Member {
  int id = -1;
  String firstName = "Porter";
  String lastName = "McGary";
  String phone = "(479) 696-1637";
  String email = "portermcgary@gmail.com";
  IconData image = Icons.person;
  Role role = Role.counselor1;
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
      case Role.wardSecretary:
        return "Ward Executive Secretary";
    }
  }
}
