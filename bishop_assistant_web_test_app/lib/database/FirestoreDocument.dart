///
/// FirestoreDocument.dart
/// bishop_assistant_web_test_app
///
/// Created by Porter McGary on 8/13/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

@Deprecated("")
class FirestoreDocument extends Document {
  static const String namePath = 'name';
  final String name;
  final int id;

  FirestoreDocument(this.id, this.name, Map<String, dynamic> map) : super(map);

  FirestoreDocument.instance(this.id, this.name) : super({});
}

@Deprecated("")
abstract class Document {
  final Map<String, dynamic> map;

  Document(this.map);
}

@Deprecated("")
enum Collections {
  assignments,
  event_types,
  events,
  member_assignments,
  member_events,
  members,
  organizations,
  organization_assignments,
  organization_events,
  organization_members,
  organization_waiting_list,
  roles,
  security,
  util
}

@Deprecated("")
extension ParseToString on Collections {
  String get string {
    return this.toString().split('.').last;
  }
}

@Deprecated("")
class EventTypesDoc extends FirestoreDocument {
  EventTypesDoc() : super(-1, "", {});
}

@Deprecated("")
class OldUtil {
  static const String counters = "counters";
}
