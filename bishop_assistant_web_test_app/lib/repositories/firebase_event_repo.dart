import 'package:bishop_assistant_web_test_app/database/firestore_helper.dart';
import 'package:models/models/event.dart';

///
/// firebase_event_repo.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 1/28/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class FirebaseEventRepo extends FirestoreHelper implements EventRepository {
  FirebaseEventRepo() : super(FirestoreCollectionPath.events);

  @override
  Future<Event?> find(EventID i) {
    // TODO: implement find
    throw UnimplementedError();
  }

  @override
  Future<Event?> insert(Event m) {
    // TODO: implement insert
    throw UnimplementedError();
  }

  @override
  Future<bool> remove(EventID i) {
    // TODO: implement remove
    throw UnimplementedError();
  }

  @override
  Future<bool> update(Event m) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
