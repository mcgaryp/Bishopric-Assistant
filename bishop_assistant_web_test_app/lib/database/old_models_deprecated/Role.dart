import 'package:bishop_assistant_web_test_app/database/FirestoreDocument.dart';

///
/// Role.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/13/21
/// Copyright 2021 porter. All rights reserved.
///

@Deprecated("")
enum Role {
  none,
  bishop,
  counselor1,
  counselor2,
  wardClerk,
  assistantWardClerk,
  wardExecutiveSecretary,
  assistantWardExecutiveSecretary
}

class MemberRole extends FirestoreDocument {
  MemberRole.model(int id, String name) : super(id, name, {});
}
