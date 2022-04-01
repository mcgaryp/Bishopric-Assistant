import 'package:the_assistant/firebase/firestore_helper.dart';
import 'package:models/models/account.dart';

///
/// firestore_pin_repository.dart
/// bishopric-assistant
///
/// Created by Joshua Bee on 3/17/22
/// Copyright 2022 Joshua Bee. All rights reserved.
///

class FirestorePinRepository extends FirestoreHelper implements PinRepository {
  FirestorePinRepository() : super(FirestoreCollectionPath.pin);

  @override
  Future<Pin?> find(PinID id) async {
    Map<String, dynamic>? map = await getSingleDocument(id);
    return DBPin.fromMap(map).toPin;
  }

  @override
  Future<bool> insert(Pin pin) async {
    DBPin dbPin = DBPin.fromPin(pin);
    String? id = await addDocument(dbPin.toMap, id: dbPin.toPinID);
    if (id == null) return false;
    return pin.id.id == id;
  }
}
