import 'package:bishop_assistant_web_test_app/firebase/firestore_helper.dart';
import 'package:models/models/assignment.dart';

///
/// $NAME.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 3/25/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class FirestoreNoteRepository extends FirestoreHelper implements NoteRepository {
  FirestoreNoteRepository() : super(FirestoreCollectionPath.notes);

  @override
  Future<Note> find(NoteID noteID) {
    // TODO: implement find
    throw UnimplementedError("Note Repo Find");
  }

  @override
  Future<bool> insert(Note note) {
    // TODO: implement insert
    throw UnimplementedError("Note Repo Insert");
  }

}