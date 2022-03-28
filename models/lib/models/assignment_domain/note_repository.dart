import 'package:models/models/assignment.dart';

///
/// $NAME.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 3/25/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

mixin NoteRepository {
  Future<bool> insert(Note note);

  Future<Note> find(NoteID noteID);
}