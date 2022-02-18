import 'package:models/models/assignment.dart';
import 'package:models/models/organization_domain/permissions.dart';

///
/// mock_note.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 1/19/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class MockNote {
  static final String mockContent = "There are no strings on me!";
  static final Permissions mockPermissions = Permissions.Maintainer;
  late final Note note;

  MockNote({String? content, Permissions? permissions}) {
    note = Note(
        content: content ?? mockContent,
        permissions: permissions ?? mockPermissions);
  }
}
