import 'package:bishop_assistant_web_test_app/database/FirestoreDocument.dart';
import 'package:bishop_assistant_web_test_app/database/old_models_deprecated/Member.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:models/shared/uuid.dart';

///
/// firestore_helper.dart
/// bishop_assistant_web_test_app
///
/// Created by Porter McGary on 8/8/2021
/// Copyright 2021 Porter McGary. All rights reserved.
///

/// For reference to Firestore Documentation see this link
/// https://pub.dev/documentation/cloud_firestore/latest/cloud_firestore/cloud_firestore-library.html)

/// [FirestoreHelper] Is intended to abstract the Firestore from any other
///   pieces in the software. This class retrieves from the database basic
///   information that is returned in a generic form of Document or Mapping.
///
/// URL to help with FireFlutter https://firebase.flutter.dev/docs/firestore/usage
abstract class FirestoreHelper<T> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirestoreCollectionPath mPath;

  FirestoreHelper(this.mPath);

  /// Once time accessors: [getSingleDocument], [getCollectionOfDocuments]
  ///
  /// These accessors will pull once and only once form the database
  /// [getSingleDocument] retrieves a single row from a specific table
  Future<DocumentSnapshot<Map<String, dynamic>>> getSingleDocument(UUID uuid,
          {FirestoreCollectionPath? path}) =>
      _firestore.collection((path ?? mPath).string).doc(uuid.id).get();

  /// [getCollectionOfDocuments] retrieves a collection of rows from a single
  /// table
  Future<QuerySnapshot<Map<String, dynamic>>> getCollectionOfDocuments(
          {FirestoreCollectionPath? path}) =>
      _firestore.collection((path ?? mPath).string).get();

  /// Realtime update accessors: [getCollectionOfDocumentsStreamed],
  /// [getSingleDocumentStreamed]
  ///
  /// These accessors will push updates to the requester everytime a specific
  /// row or table is changed
  /// [getCollectionOfDocumentsStreamed] gives a new collection of rows from a
  /// specific table everytime there is a change to the information in the table
  Stream<QuerySnapshot<Map<String, dynamic>>> getCollectionOfDocumentsStreamed(
      {FirestoreCollectionPath? path, String? field, Object? isEqualTo}) {
    if (field != null)
      return _firestore
          .collection((path ?? mPath).string)
          .where(field, isEqualTo: isEqualTo)
          .snapshots();
    return _firestore.collection((path ?? mPath).string).snapshots();
  }

  /// [getSingleDocumentStreamed] gives a new row every time there is a change
  /// to that row
  Stream<DocumentSnapshot<Map<String, dynamic>>> getSingleDocumentStreamed(
          UUID uuid,
          {FirestoreCollectionPath? path}) =>
      _firestore.collection((path ?? mPath).string).doc(uuid.id).snapshots();

  /// [addDocument] to the database
  Future<bool> addDocument(Map<String, Object?> map,
      {UUID? id, FirestoreCollectionPath? path}) async {
    bool result = true;

    String? strId = id == null ? null : id.id;

    await _firestore
        .collection((path ?? mPath).string)
        .doc(strId)
        .set(map)
        .onError<bool>((error, stackTrace) => result = false);

    return result;
  }

  /// [updateDocument] in a collection
  Future<bool> updateDocument(Map<String, Object?> map, UUID uuid,
      {FirestoreCollectionPath? path}) async {
    bool result = true;

    await _firestore
        .collection((path ?? mPath).string)
        .doc(uuid.id)
        .update(map)
        .onError<bool>((error, stackTrace) => result = false);

    return result;
  }

  /// [removeDocument] in a collection
  Future<bool> removeDocument(UUID id, {FirestoreCollectionPath? path}) async {
    bool result = true;

    await _firestore
        .collection((path ?? mPath).string)
        .doc(id.id)
        .delete()
        .onError<bool>((error, stackTrace) => result = false);

    return result;
  }

  /// [getNextID] pulls the next id from the database for a specific table
  Future<Map<String, dynamic>?> getNextID() async {
    // Get the next ID from the counters
    DocumentSnapshot<Map<String, dynamic>> counterMap = await _firestore
        .collection(FirestoreCollectionPath.util.string)
        .doc(Util.counters)
        .get();

    Map<String, dynamic>? counterData = counterMap.data();
    return counterData;
  }

  /// [incrementId] increments a given id in the database for a specific table
  Future<bool> incrementId(Map<String, dynamic> map,
      {FirestoreCollectionPath? path}) async {
    Map<String, dynamic> counterMap = map;
    // increase counter
    counterMap[(path ?? mPath).string] += 1;

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

/// [FirestoreCollectionPath] paths to specific tables in the database
enum FirestoreCollectionPath {
  accounts,
  organizations,
  members,
  organization_members,
  organization_requests,
  util
}

/// [FirestoreCollectionPathExtension] adds additional getters, functions to the
/// [FirestoreCollectionPath] enum
extension FirestoreCollectionPathExtension on FirestoreCollectionPath {
  /// [string] turns the enum into a string value exactly the way it is spelt in
  /// the enum
  String get string => this.toString().split('.').last;
}

/// [Util] is a helper class to access the one table in the database that holds
/// the id and other utilities in the database
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

  /// APPROVED
  static Future<QuerySnapshot> getCollection(Collections path) =>
      _firestore.collection(path.string).get();

  /// APPROVED
  static Future<DocumentSnapshot> getDocument(Collections path, int memberID) =>
      _firestore.collection(path.string).doc(memberID.toString()).get();

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
  /// APPROVED
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
  /// APPROVED
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
  static Future<OldMember?> findMember(String username) async {
    final QuerySnapshot snapshot =
        await _firestore.collection(Collections.members.string).get();
    final List<QueryDocumentSnapshot> list = listQuerySnap(snapshot);

    for (QueryDocumentSnapshot snap in list) {
      if (snap[OldMember.emailPath] == username) {
        return OldMember(
          id: int.parse(snap.id),
          firstName: snap[OldMember.firstNamePath],
          lastName: snap[OldMember.lastNamePath],
          phone: snap[OldMember.phonePath],
          email: snap[OldMember.emailPath],
          password: snap[OldMember.passwordPath],
          role: ParseRolesToString.roleFromInt(snap[OldMember.roleIdPath]),
        );
      }
    }

    return null;
  }
}
