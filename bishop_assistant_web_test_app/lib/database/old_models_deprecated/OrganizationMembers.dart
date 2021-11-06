import 'package:bishop_assistant_web_test_app/database/FirestoreDocument.dart';
import 'package:bishop_assistant_web_test_app/database/firestore_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

///
/// OrganizationMembers.dart
/// bishop_assistant_web_test_app
///
/// Created by Po on 8/22/21
/// Copyright 2021 Po. All rights reserved.
///
@Deprecated("")
class OrganizationMembers extends Document {
  static const String memberIDPath = "member_id";
  static const String organizationIDPath = "organization_id";

  OrganizationMembers(int memberID, int organizationID)
      : super({memberIDPath: memberID, organizationIDPath: organizationID});

  static Future<int> findOrganizationID(int memberID) async {
    QuerySnapshot collection = await OldFirestoreHelper.getCollection(
        Collections.organization_members);

    for (QueryDocumentSnapshot document in collection.docs) {
      if (document[memberIDPath] == memberID)
        return document[organizationIDPath];
    }

    return -1;
  }

  static Future<int> findMemberID(int organizationID) async {
    QuerySnapshot collection = await OldFirestoreHelper.getCollection(
        Collections.organization_members);

    for (QueryDocumentSnapshot document in collection.docs) {
      if (document[organizationIDPath] == organizationID)
        return document[memberIDPath];
    }

    return -1;
  }
}
