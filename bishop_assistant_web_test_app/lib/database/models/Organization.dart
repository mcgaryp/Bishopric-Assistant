import 'package:bishop_assistant_web_test_app/database/FirestoreDocument.dart';

///
/// Organization.dart
/// bishop_assistant_web_test_app
///
/// Created by Po on 8/22/21
/// Copyright 2021 Po. All rights reserved.
///

class Organization extends FirestoreDocument {
  Organization(
    int id,
    String name,
  ) : super(id, name, {FirestoreDocument.namePath: name});

  Organization.create(String name)
      : super(-1, name, {FirestoreDocument.namePath: name});
}
