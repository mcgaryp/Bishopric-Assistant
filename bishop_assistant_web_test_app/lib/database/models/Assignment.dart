import 'package:bishop_assistant_web_test_app/database/DatabaseModel.dart';
import 'package:bishop_assistant_web_test_app/database/models/Member.dart';

///
/// Assignment.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/14/21
/// Copyright 2021 porter. All rights reserved.
///

class Assignment extends DatabaseModel {
  late DateTime dateTime;
  late Member assignee;
  String? notes;

  Assignment(id, name, this.dateTime, this.assignee, {this.notes})
      : super(id, name);

  Assignment.model(int id, String name) : super(id, name);
}
