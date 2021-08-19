import 'package:bishop_assistant_web_test_app/database/models/Assignment.dart';
import 'package:bishop_assistant_web_test_app/database/models/Member.dart';
import 'package:bishop_assistant_web_test_app/database/models/Role.dart';
import 'package:bishop_assistant_web_test_app/util/DatabasePaths.dart';

///
/// DatabaseModel.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/15/21
/// Copyright 2021 porter. All rights reserved.
///

abstract class DatabaseModel {
  final int id;
  final String name;

  DatabaseModel(this.id, this.name);
}

extension InstanceOfDatabaseModel on Collections {
  DatabaseModel instance(int id, String name) {
    switch (this) {
      case Collections.assignments:
        return Assignment.model(id, name);
      case Collections.event_types:
        throw Exception(
            "${this.string()} DatabaseModel class has not been implemented yet");
      case Collections.events:
        throw Exception(
            "${this.string()} DatabaseModel class has not been implemented yet");
      case Collections.member_assignments:
        throw Exception(
            "${this.string()} DatabaseModel class has not been implemented yet");
      case Collections.member_events:
        throw Exception(
            "${this.string()} DatabaseModel class has not been implemented yet");
      case Collections.members:
        return Member.model(id, name);
      case Collections.organizations:
        throw Exception(
            "${this.string()} DatabaseModel class has not been implemented yet");
      case Collections.organization_assignments:
        throw Exception(
            "${this.string()} DatabaseModel class has not been implemented yet");
      case Collections.organization_events:
        throw Exception(
            "${this.string()} DatabaseModel class has not been implemented yet");
      case Collections.organization_members:
        throw Exception(
            "${this.string()} DatabaseModel class has not been implemented yet");
      case Collections.roles:
        return MemberRole.model(id, name);
      case Collections.security:
        throw Exception(
            "${this.string()} DatabaseModel class has not been implemented yet");
      case Collections.util:
        throw Exception(
            "${this.string()} DatabaseModel class has not been implemented yet");
    }
  }
}
