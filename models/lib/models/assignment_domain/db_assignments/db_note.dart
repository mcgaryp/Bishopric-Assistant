///
/// $NAME.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 3/25/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class DBNote {
  static const String idKey = "DB Note ID";
  static const String contentKey = "DB Note Content";

  String? noteID;
  String? content;

  DBNote({this.noteID, this.content});

  DBNote.fromMap(Map<String, dynamic> map)
      : this(
          noteID: map[idKey],
          content: map[contentKey],
        );

  Map<String, dynamic> get toMap => {
        idKey: noteID,
        contentKey: content,
      };
}
