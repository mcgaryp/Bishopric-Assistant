import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

///
/// FirestoreHelper.dart
/// bishop_assistant_web_test_app
///
/// Created by Porter McGary on 8/8/2021
/// Copyright 2021 Porter McGary. All rights reserved.
///

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
