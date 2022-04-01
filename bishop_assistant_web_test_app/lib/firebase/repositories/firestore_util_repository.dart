import 'package:the_assistant/firebase/firestore_helper.dart';
import 'package:models/shared/uuid.dart';

///
/// $NAME.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 3/31/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class FirestoreUtilRepository extends FirestoreHelper {
  FirestoreUtilRepository() : super(FirestoreCollectionPath.util);
  
  Future<String> getIssuesEmail() async {
    Map<String, dynamic> map = await getSingleDocument(UtilID("bug_reports"));
    return map["email"];
  }
}

class UtilID extends UUID {
  UtilID(String id) : super(id);
}