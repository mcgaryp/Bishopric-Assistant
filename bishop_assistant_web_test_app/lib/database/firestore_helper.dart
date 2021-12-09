import 'package:cloud_firestore/cloud_firestore.dart';
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
