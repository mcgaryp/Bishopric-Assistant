import 'package:the_assistant/firebase/firestore_helper.dart';
import 'package:models/models/event.dart';

///
/// $NAME.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 3/25/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class FirestoreEventRepository extends FirestoreHelper
    implements EventRepository {
  FirestoreEventRepository() : super(FirestoreCollectionPath.events);
}
