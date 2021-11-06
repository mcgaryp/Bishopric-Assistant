import 'package:bishop_assistant_web_test_app/database/FirestoreDocument.dart';
import 'package:bishop_assistant_web_test_app/database/firestore_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

///
/// OrganizationEvents.dart
/// bishop_assistant_web_test_app
///
/// Created by Po on 8/22/21
/// Copyright 2021 Po. All rights reserved.
///
@Deprecated("")
class OrganizationEvents extends Document {
  static const String eventIDPath = "event_id";
  static const String organizationIDPath = "organization_id";

  OrganizationEvents(int eventID, int organizationID)
      : super({eventIDPath: eventID, organizationIDPath: organizationID});

  static Future<int> findOrganizationID(int eventID) async {
    QuerySnapshot collection =
        await OldFirestoreHelper.getCollection(Collections.organization_events);

    for (QueryDocumentSnapshot document in collection.docs) {
      if (document[eventIDPath] == eventID) return document[organizationIDPath];
    }

    return -1;
  }

  static Future<int> findEventID(int organizationID) async {
    QuerySnapshot collection =
        await OldFirestoreHelper.getCollection(Collections.organization_events);

    for (QueryDocumentSnapshot document in collection.docs) {
      if (document[organizationIDPath] == organizationID)
        return document[eventIDPath];
    }

    return -1;
  }
}
