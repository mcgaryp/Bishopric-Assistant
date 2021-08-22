///
/// FirestoreDocument.dart
/// bishop_assistant_web_test_app
///
/// Created by Porter McGary on 8/13/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

// TODO: Comments
class FirestoreDocument extends Document {
  static const String namePath = 'name';
  final String name;
  final int id;

  FirestoreDocument(this.id, this.name, Map<String, dynamic> map) : super(map);

  FirestoreDocument.instance(this.id, this.name) : super({});
}

abstract class Document {
  final Map<String, dynamic> map;

  Document(this.map);
}

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
  roles,
  security,
  util
}

extension ParseToString on Collections {
  String string() => this.toString().split('.').last;
}

// TODO: Replace
class EventTypesDoc extends FirestoreDocument {
  EventTypesDoc() : super(-1, "", {});
}

// TODO: Do something with this, it's so far only used in the FirestoreHelper.dart file
class Util {
  static const String counters = "counters";
}
