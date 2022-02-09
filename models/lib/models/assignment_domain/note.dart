import 'package:models/models/organization_domain/permissions.dart';
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
  static final String permissionsKey = "note permissions";
  String content;
  final Permissions permissions;

  Note({required this.content, required this.permissions});

  Note.fromMap(Map<String, dynamic> map)
      : this(
            content: map[contentKey],
            permissions: PermissionsExtension.fromString(map[permissionsKey]));

  // Who can view the Notes?
  // - Those Equal to or greater than the permission level of the note
  bool canView(Permissions permissions) {
    return permissions >= this.permissions;
  }

  @override
  bool sameValueAs(Note other) {
    return this.content == other.content &&
        this.permissions == other.permissions;
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != Note) return false;
    return sameValueAs(other as Note);
  }

  @override
  Map<String, dynamic> get toMap =>
      {contentKey: content, permissionsKey: permissions.string};
}
