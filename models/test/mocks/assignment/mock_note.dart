import 'package:models/models/assignment.dart';
import 'package:models/models/organization.dart';

import '../organization/mock_authorization.dart';

///
/// mock_note.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 1/19/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class MockNote {
  static final String mockContent = "There are no strings on me!";
  static final Authorization mockAuthorization =
      MockAuthorization().authorization;
  late final Note note;

  MockNote({String? content, Authorization? authorization}) {
    note = Note(
        content: content ?? mockContent,
        authorization: authorization ?? mockAuthorization);
  }
}
