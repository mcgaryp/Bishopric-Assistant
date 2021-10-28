import 'package:bishop_assistant_web_test_app/database/FirestoreDocument.dart';
import 'package:bishop_assistant_web_test_app/database/FirestoreHelper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

///
/// OrganizationWaitingList.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 9/7/21
/// Copyright 2021 porter. All rights reserved.
///
@Deprecated("")
class OrganizationWaitingList extends Document {
  static const String memberIDPath = "member_id";
  static const String organizationIDPath = "organization_id";

  OrganizationWaitingList(int memberID, int organizationID)
      : super({memberIDPath: memberID, organizationIDPath: organizationID});

  // TODO: potentially use int?
  static Future<int> findOrganizationID(int memberID) async {
    QuerySnapshot collection = await OldFirestoreHelper.getCollection(
        Collections.organization_waiting_list);

    for (QueryDocumentSnapshot document in collection.docs) {
      if (document[memberIDPath] == memberID)
        return document[organizationIDPath];
    }

    return -1;
  }

  // TODO: potentially use int?
  static Future<int> findMemberID(int organizationID) async {
    QuerySnapshot collection = await OldFirestoreHelper.getCollection(
        Collections.organization_waiting_list);

    for (QueryDocumentSnapshot document in collection.docs) {
      if (document[organizationIDPath] == organizationID)
        return document[memberIDPath];
    }

    return -1;
  }
}
