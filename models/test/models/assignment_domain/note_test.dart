import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/assignment.dart';
import 'package:models/models/organization_domain/permissions.dart';
import 'package:models/shared/test.dart';

import '../../mocks/assignment/mock_note.dart';

///
/// note_test.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 1/19/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class NoteTest implements Test {
  static givenValidContentReturnValidContent() {
    Note note = MockNote().note;
    String content = note.content;
    expect(note.content, content);
    content = "";
    note = MockNote(content: content).note;
    expect(note.content, content);
  }

  static givenMapReturnValidMap() {
    Note note = MockNote().note;
    Map<String, dynamic> map = note.toMap;
    expect(Note.fromMap(map) == note, true);
  }

  static comparisonTests() {
    Note assignee = MockNote().note;
    Note secondAssignee = MockNote().note;
    expect(assignee == secondAssignee, true);
    expect(secondAssignee == assignee, true);
    expect(assignee.sameValueAs(secondAssignee), true);
    expect(assignee != "Not Assignee", true);
    expect(assignee == "Not Assignee", false);
    expect("Not Assignee" == assignee, false);
  }

  static final creator = Permissions.Creator;
  static final maintainer = Permissions.Maintainer;
  static final reporter = Permissions.Reporter;
  static final viewer = Permissions.Viewer;

  // verify Can View
  static verifyCanView() {
    Note note = MockNote(permissions: viewer).note;
    expect(note.canView(creator), true);
    expect(note.canView(maintainer), true);
    expect(note.canView(reporter), true);
    expect(note.canView(viewer), true);

    note = MockNote(permissions: reporter).note;
    expect(note.canView(creator), true);
    expect(note.canView(maintainer), true);
    expect(note.canView(reporter), true);
    expect(note.canView(viewer), false);

    note = MockNote(permissions: maintainer).note;
    expect(note.canView(creator), true);
    expect(note.canView(maintainer), true);
    expect(note.canView(reporter), false);
    expect(note.canView(viewer), false);

    note = MockNote(permissions: creator).note;
    expect(note.canView(creator), true);
    expect(note.canView(maintainer), false);
    expect(note.canView(reporter), false);
    expect(note.canView(viewer), false);
  }
}

runNoteTests() {
  group("Notes Test", () {
    test("Content String", NoteTest.givenValidContentReturnValidContent);
    test("Mapping", NoteTest.givenMapReturnValidMap);
    test("Comparison", NoteTest.comparisonTests);
    test("Verify Can View", NoteTest.verifyCanView);
  });
}
