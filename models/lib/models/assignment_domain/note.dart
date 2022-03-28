import 'package:models/models/organization.dart';
import 'package:models/shared/domain_driven_design/value_object.dart';

///
/// note.dart
/// bishopric-assistant
///
/// Created by Joshua Bee on 1/18/22
/// Copyright 2022 Joshua Bee. All rights reserved.
///

class Note extends ValueObject<Note> {
  static final String contentKey = "note content";
  static final String authorizationKey = "Note Authorization";
  String content;
  final Authorization authorization;

  Note({required this.content, required this.authorization});

  Note.fromMap(Map<String, dynamic> map)
      : this(
            content: map[contentKey],
            authorization: Authorization.fromMap(map[authorizationKey]));

  // Who can view the Notes?
  // - Those Equal to or greater than the permission level of the note
  bool canView(Authorization authorization) {
    return authorization >= this.authorization;
  }

  @override
  bool sameValueAs(Note other) {
    return this.content == other.content &&
        this.authorization == other.authorization;
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != Note) return false;
    return sameValueAs(other as Note);
  }

  @override
  Map<String, dynamic> get toMap => {
        contentKey: content,
        authorizationKey: authorization.toMap,
      };
}
