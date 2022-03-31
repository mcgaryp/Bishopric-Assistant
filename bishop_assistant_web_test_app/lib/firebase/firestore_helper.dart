import 'package:bishop_assistant_web_test_app/firebase/firebase_instances.dart';
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
///   pieces in the software. This class retrieves from the firebase basic
///   information that is returned in a generic form of Document or Mapping.
///
/// URL to help with FireFlutter https://firebase.flutter.dev/docs/firestore/usage
abstract class FirestoreHelper {
  static final FirebaseFirestore _firestore = FirebaseInstances.firestore;

  final FirestoreCollectionPath mPath;
  static const String documentID = "Document ID";

  FirestoreHelper(this.mPath);

  /// Once time accessors: [getSingleDocument], [getCollectionOfDocuments]
  ///
  /// These accessors will pull once and only once form the firebase
  /// [getSingleDocument] retrieves a single row from a specific table
  Future<Map<String, dynamic>> getSingleDocument(UUID uuid,
      {FirestoreCollectionPath? path}) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection((path ?? mPath).name).doc(uuid.id).get();
    Map<String, dynamic>? map = snapshot.data();
    if (map == null) {
      throw Exception(
          "Firestore could not find the document with id: `${uuid.id}` at path `${(path ?? mPath).name}`");
    }
    return map;
  }

  /// [getCollectionOfDocuments] retrieves a collection of rows from a single
  /// table
  Future<List<Map<String, dynamic>>> getCollectionOfDocuments(
      {FirestoreCollectionPath? path,
      String? field,
      Object? isEqualTo,
      String? sortBy}) async {
    QuerySnapshot<Map<String, dynamic>> snapshot;
    if (field != null) {
      if (sortBy != null) {
        snapshot = await _firestore
            .collection((path ?? mPath).name)
            .orderBy(sortBy, descending: false)
            .where(field, isEqualTo: isEqualTo)
            .get();
      } else {
        snapshot = await _firestore
            .collection((path ?? mPath).name)
            .where(field, isEqualTo: isEqualTo)
            .get();
      }
    } else
      snapshot = await _firestore.collection((path ?? mPath).name).get();
    return snapshot.docs.map<Map<String, dynamic>>((document) {
      return document.data();
    }).toList();
  }

  /// Realtime update accessors: [getCollectionOfDocumentsStreamed],
  /// [getSingleDocumentStreamed]
  ///
  /// These accessors will push updates to the requester everytime a specific
  /// row or table is changed
  /// [getCollectionOfDocumentsStreamed] gives a new collection of rows from a
  /// specific table everytime there is a change to the information in the table
  Stream<List<Map<String, dynamic>>> getCollectionOfDocumentsStreamed(
      {FirestoreCollectionPath? path,
      String? field,
      Object? isEqualTo,
      String? sortBy}) {
    Stream<QuerySnapshot<Map<String, dynamic>>> snapshot;
    if (field != null) {
      if (sortBy != null) {
        snapshot = _firestore
            .collection((path ?? mPath).name)
            .where(field, isEqualTo: isEqualTo)
            .orderBy(sortBy, descending: false)
            .snapshots();
      } else {
        snapshot = _firestore
            .collection((path ?? mPath).name)
            .where(field, isEqualTo: isEqualTo)
            .snapshots();
      }
    } else {
      snapshot = _firestore.collection((path ?? mPath).name).snapshots();
    }
    return snapshot.asyncMap<List<Map<String, dynamic>>>(
        (event) => event.docs.map<Map<String, dynamic>>((document) {
              return document.data();
            }).toList());
  }

  /// [getSingleDocumentStreamed] gives a new row every time there is a change
  /// to that row
  Stream<Map<String, dynamic>?> getSingleDocumentStreamed(UUID uuid,
      {FirestoreCollectionPath? path}) {
    Stream<DocumentSnapshot<Map<String, dynamic>>> stream =
        _firestore.collection((path ?? mPath).name).doc(uuid.id).snapshots();
    return stream.asyncMap<Map<String, dynamic>?>((event) {
      Map<String, dynamic>? map = event.data();
      if (map == null) return null;
      return map;
    });
  }

  /// [addDocument] to the firebase
  Future<String?> addDocument(Map<String, Object?> map,
      {UUID? id, FirestoreCollectionPath? path}) async {
    String? result;
    String? strId = id == null ? null : id.id;

    DocumentReference ref =
        _firestore.collection((path ?? mPath).name).doc(strId);

    result = (ref.id);

    await ref.set(map).onError<bool>((error, stackTrace) => result = null);

    return result;
  }

  /// [updateDocument] in a collection
  Future<bool> updateDocument(Map<String, Object?> map, UUID uuid,
      {FirestoreCollectionPath? path}) async {
    bool result = true;

    await _firestore
        .collection((path ?? mPath).name)
        .doc(uuid.id)
        .update(map)
        .onError<bool>((error, stackTrace) => result = false);

    return result;
  }

  /// [removeDocument] in a collection
  Future<bool> removeDocument(UUID id, {FirestoreCollectionPath? path}) async {
    bool result = true;

    await _firestore
        .collection((path ?? mPath).name)
        .doc(id.id)
        .delete()
        .onError<bool>((error, stackTrace) => result = false);

    return result;
  }
}

/// [FirestoreCollectionPath] paths to specific tables in the firebase
/// Keep these in alphabetical order
enum FirestoreCollectionPath {
  accounts,
  assignments,
  authorizations,
  contact,
  credentials,
  events,
  members,
  name,
  notes,
  @Deprecated("")
  organization_assignments,
  @Deprecated("")
  organization_members,
  @Deprecated("")
  organization_requests,
  organizations,
  pin,
  requests,
  roles,
  util
}

/// [Util] is a helper class to access the one table in the firebase that holds
/// the id and other utilities in the firebase
class Util {
  static final _UtilID email = _UtilID("email");
}

class _UtilID extends UUID {
  _UtilID(String id) : super(id);

  @override
  bool sameValueAs(UUID other) {
    return this == other;
  }

  @override
  bool operator ==(Object object) {
    if (object.runtimeType != _UtilID) return false;
    return sameValueAs(object as UUID);
  }

  @override
  Map<String, dynamic> get toMap => throw UnimplementedError();
}
