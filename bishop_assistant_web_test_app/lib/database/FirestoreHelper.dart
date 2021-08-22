import 'package:bishop_assistant_web_test_app/database/FirestoreDocument.dart';
import 'package:bishop_assistant_web_test_app/database/models/Member.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// FirestoreHelper.dart
/// bishop_assistant_web_test_app
///
/// Created by Porter McGary on 8/8/2021
/// Copyright 2021 Porter McGary. All rights reserved.
///

// TODO: Find out how to notify the user they are offline
// TODO: Define either in a readme or in this file what different Firebase Objects are and do
//    Running list of items to document from Firebase
//      - Snapshot
//        - QuerySnapshot
//        - AsyncSnapShot
//        - QueryDocumentSnapshot
//        - DocumentSnapshot
//        -
//      - Stream
//      - Collection
//      - Document
// TODO: Comment
class FirestoreHelper {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Return a Stream<QuerySnapshot> of a collection. Automatically Updates when
  ///  database changes
  static Stream<QuerySnapshot> stream(String path) =>
      _firestore.collection(path).snapshots();

  /// Return a List of Document Snapshots
  static List<DocumentSnapshot> listDocSnap(
      AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasError) {
      // Return toast with 'Something went wrong'
      return [];
    }

    if (snapshot.connectionState == ConnectionState.waiting) {
      // Toggle "Loading" indicator
      return [];
    }

    var data = snapshot.data!.docs;
    data.sort(sortDocById);
    return data;
  }

  /// Return CollectionReference that will not automatically update with database
  static CollectionReference reference(String path) =>
      _firestore.collection(path);

  /// Return a List of Query Document Snapshots
  static List<QueryDocumentSnapshot> listAsyncQuerySnap(
      AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasError) {
      // Return toast with 'Something went wrong'
      return [];
    }

    if (snapshot.connectionState == ConnectionState.waiting) {
      // Toggle "Loading" indicator
      return [];
    }

    var data = snapshot.data!.docs;
    data.sort(sortQueryById);
    return data;
  }

  /// Return a List of Query Document Snapshots
  static List<QueryDocumentSnapshot> listQuerySnap(QuerySnapshot snapshot) {
    var data = snapshot.docs;
    data.sort(sortQueryById);
    return data;
  }

  /// Sort DocumentSnapshots by ID
  static int sortDocById(DocumentSnapshot a, DocumentSnapshot b) {
    int aInt = int.parse(a.id);
    int bInt = int.parse(b.id);
    if (aInt > bInt) {
      return 1;
    } else if (aInt < bInt) {
      return -1;
    }
    return 0;
  }

  /// Sort QueryDocumentSnapshot by ID
  static int sortQueryById(QueryDocumentSnapshot a, QueryDocumentSnapshot b) {
    int aInt = int.parse(a.id);
    int bInt = int.parse(b.id);
    if (aInt > bInt) {
      return 1;
    } else if (aInt < bInt) {
      return -1;
    }
    return 0;
  }

  // TODO: Comment
  // Used to add a document to the database
  static void addDocument(Collections path,
      {required Document doc,
      required Null Function(dynamic) error,
      required Null Function(int) success}) async {
    try {
      // Get next ID from Database
      Map<String, dynamic> counterMap = await _getNextID();
      int nextID = counterMap[path.string()];

      // add the item to the database
      await _firestore
          .collection(path.string())
          .doc(nextID.toString())
          .set(doc.map)
          .then((value) {
        // increase counter
        counterMap[path.string()] += 1;

        // set new value in counter
        _firestore
            .collection(Collections.util.string())
            .doc(Util.counters)
            .update(counterMap)
            .then((value) {
          // activate callback
          success(nextID);
        });
      }).catchError(error);
    } catch (e) {
      error(e);
    }
  }

  // TODO: Comment
  static Future<Map<String, dynamic>> _getNextID() async {
    // Get the next ID from the counters
    DocumentSnapshot<Map<String, dynamic>> counterMap = await _firestore
        .collection(Collections.util.string())
        .doc(Util.counters)
        .get();

    Map<String, dynamic>? counterData = counterMap.data();

    if (counterData == null)
      throw Exception("Invalid data in Counter Collection");

    return counterData;
  }

  // Find Member uses a username to find the account of a member
  // TODO: Should this be a more general way?
  static Future<Member?> findMember(String username) async {
    final QuerySnapshot snapshot =
        await _firestore.collection(Collections.members.string()).get();
    final List<QueryDocumentSnapshot> list = listQuerySnap(snapshot);

    for (QueryDocumentSnapshot snap in list) {
      if (snap[Member.emailPath] == username) {
        return Member(
          id: int.parse(snap.id),
          firstName: snap[Member.firstNamePath],
          lastName: snap[Member.lastNamePath],
          phone: snap[Member.phonePath],
          email: snap[Member.emailPath],
          password: snap[Member.passwordPath],
          role: ParseRolesToString.roleFromInt(snap[Member.roleIdPath]),
        );
      }
    }

    return null;
  }

// /// Constant items from database
// ///   - Roles
// ///   - Security
// ///   - Event Types
// late final List<Security> securities = _getSecurities();
// late final List<Role> roles;
// late final List<EventType> eventTypes;
//
// FirestoreHelper._privateConstructor() {
//   _setupDatabaseConstants();
// }
//
// static final FirestoreHelper _instance =
//     FirestoreHelper._privateConstructor();
//
// factory FirestoreHelper() {
//   return _instance;
// }
//
// void _setupDatabaseConstants() async {
//   securities = await _getSecurities();
//   roles = await _getRoles();
//   eventTypes = await _getEventTypes();
// }
//
// Future<List<Role>> _getRoles() async {
//   QuerySnapshot roles = await _firestore.collection(Collections.roles).get();
//
//   return roles.docs
//       .map((e) => Role(
//           id: int.parse(e.id),
//           name: e[RolesDoc.name],
//           security: securities[e[RolesDoc.security] - 1]))
//       .toList();
// }
//
// List<Security> _getSecurities() async {
//   QuerySnapshot securities =
//       await _firestore.collection(Collections.security).get();
//
//   return securities.docs
//       .map((e) => Security(id: int.parse(e.id), name: e[SecurityDoc.name]))
//       .toList();
// }
//
// Future<List<EventType>> _getEventTypes() async {
//   QuerySnapshot eventTypes =
//       await _firestore.collection(Collections.eventTypes).get();
//
//   return eventTypes.docs
//       .map((e) => EventType(id: int.parse(e.id), name: e[EventTypesDoc.name]))
//       .toList();
// }
}
