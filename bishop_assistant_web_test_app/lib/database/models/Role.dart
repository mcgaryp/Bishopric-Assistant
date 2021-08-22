import 'package:bishop_assistant_web_test_app/database/DatabaseModel.dart';

///
/// Role.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/13/21
/// Copyright 2021 porter. All rights reserved.
///

// TODO: Comment
// TODO: Is there a smarter way to look at and evaluate this data from the database?
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

// TODO: Should a class be used instead as a replacement for the enum above?
class MemberRole extends DatabaseModel {
  MemberRole.model(int id, String name) : super(id, name, {});
}
