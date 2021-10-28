import 'package:bishop_assistant_web_test_app/database/FirestoreDocument.dart';
import 'package:bishop_assistant_web_test_app/database/old_models_deprecated/Member.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:models/shared/uuid.dart';

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
//      - Stream
//      - Collection
//      - Document
// APPROVED vs NOT APPROVED
//  - Approved methods are good to stay around
//  - Not Approved methods need either work put into them and will change or should be removed

/// TODO Comment, Remove Deprecated class
///
/// URL to help with FireFlutter https://firebase.flutter.dev/docs/firestore/usage
abstract class FirestoreHelper<T> {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Once time accessors
  static Future<DocumentSnapshot<Map<String, dynamic>>> getSingleDocument(
          FirestoreCollectionPath path, UUID uuid) =>
      _firestore.collection(path.string).doc(uuid.id).get();

  static Future<QuerySnapshot<Map<String, dynamic>>> getCollectionOfDocuments(
          FirestoreCollectionPath path) =>
      _firestore.collection(path.string).get();

  /// Realtime update accessors
  static Stream<QuerySnapshot<Map<String, dynamic>>>
      getCollectionOfDocumentsStreamed(FirestoreCollectionPath path) =>
          _firestore.collection(path.string).snapshots();

  static Stream<DocumentSnapshot<Map<String, dynamic>>>
      getSingleDocumentStreamed(FirestoreCollectionPath path, UUID uuid) =>
          _firestore.collection(path.string).doc(uuid.id).snapshots();

  /// TODO Comment
  static Future<bool> addDocument(
      FirestoreCollectionPath path, Map<String, Object?> map, UUID uuid) async {
    bool result = true;

    await _firestore
        .collection(path.string)
        .doc(uuid.id)
        .set(map)
        .onError<bool>((error, stackTrace) => result = false);

    return result;
  }

  /// TODO: Comment
  static Future<Map<String, dynamic>?> getNextID() async {
    // Get the next ID from the counters
    DocumentSnapshot<Map<String, dynamic>> counterMap = await _firestore
        .collection(FirestoreCollectionPath.util.string)
        .doc(Util.counters)
        .get();

    Map<String, dynamic>? counterData = counterMap.data();

    return counterData;
  }

  /// TODO Comment
  static Future<bool> incrementId(
      FirestoreCollectionPath path, Map<String, dynamic> map) async {
    Map<String, dynamic> counterMap = map;
    // increase counter
    counterMap[path.string] += 1;

    bool result = true;

    // set new value in counter
    await _firestore
        .collection(FirestoreCollectionPath.util.string)
        .doc(Util.counters)
        .update(counterMap)
        .onError((error, stackTrace) {
      result = false;
      throw Exception("Error Incrementing $path: $error => $stackTrace");
    });

    return result;
  }
}

enum FirestoreCollectionPath { accounts, util }

extension FirestoreCollectionPathExtension on FirestoreCollectionPath {
  String get string {
    return this.toString().split('.').last;
  }
}

class Util {
  static const String counters = "counters";
}

//                                                  ***                       //
//                    ****   **   ******            ***                       //
//                    ** **  **  ***  ***           ***                       //
//                    **  ** **  **    **        **     **                    //
//                    **   * **  ***  ***          ** **                      //
//                    **    ***   ******            ***                       //
//                                                   *                        //

@Deprecated("Use FirestoreHelper")
abstract class OldFirestoreHelper {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// TODO: Comment
  /// APPROVED
  static Future<QuerySnapshot> getCollection(Collections path) =>
      _firestore.collection(path.string).get();

  /// TODO: Comment
  /// APPROVED
  static Future<DocumentSnapshot> getDocument(Collections path, int memberID) =>
      _firestore.collection(path.string).doc(memberID.toString()).get();

  /// Return a Stream<QuerySnapshot> of a collection. Automatically Updates when
  ///  database changes
  // TODO: NOT APPROVED
  static Stream<QuerySnapshot> stream(String path) =>
      _firestore.collection(path).snapshots();

  /// Return a List of Document Snapshots
  // TODO: NOT APPROVED
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
  /// APPROVED
  static CollectionReference reference(String path) =>
      _firestore.collection(path);

  /// Return a List of Query Document Snapshots
  // TODO: NOT APPROVED
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
  /// APPROVED
  static List<QueryDocumentSnapshot> listQuerySnap(QuerySnapshot snapshot) {
    var data = snapshot.docs;
    data.sort(sortQueryById);
    return data;
  }

  /// Sort DocumentSnapshots by ID
  // TODO: NOT APPROVED
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
  /// APPROVED
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
  /// APPROVED
  static Future<void> addDocument(Collections path,
      {required Document doc,
      required Function(dynamic) error,
      required Function(int) success}) async {
    try {
      // Get next ID from Database
      Map<String, dynamic> counterMap = await _getNextID();
      int nextID = counterMap[path.string];

      // add the item to the database
      await _firestore
          .collection(path.string)
          .doc(nextID.toString())
          .set(doc.map)
          .then((value) {
        // increase counter
        counterMap[path.string] += 1;

        // set new value in counter
        _firestore
            .collection(Collections.util.string)
            .doc(OldUtil.counters)
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
  /// APPROVED
  static Future<Map<String, dynamic>> _getNextID() async {
    // Get the next ID from the counters
    DocumentSnapshot<Map<String, dynamic>> counterMap = await _firestore
        .collection(Collections.util.string)
        .doc(OldUtil.counters)
        .get();

    Map<String, dynamic>? counterData = counterMap.data();

    if (counterData == null)
      throw Exception("Invalid data in Counter Collection");

    return counterData;
  }

  // Find Member uses a username to find the account of a member
  // TODO: Should this be a more general way?
  // TODO: NOT APPROVED
  static Future<Member?> findMember(String username) async {
    final QuerySnapshot snapshot =
        await _firestore.collection(Collections.members.string).get();
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
}
