import 'package:models/models/account_domain/name.dart';

///
/// $FILE_NAME.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 3/16/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class DBName {
  static const String idKey = "Name ID";
  static const String firstKey = "Name First";
  static const String lastKey = "Name Last";

  String? first;
  String? last;
  String? id;

  DBName({this.id, this.first, this.last});

  DBName.fromMap(Map<String, dynamic> map)
      : this(
          id: map[idKey],
          first: map[firstKey],
          last: map[lastKey],
        );

  DBName.fromName(Name name) : this(first: name.first, last: name.last);

  Name get toName {
    if (last == null || first == null)
      throw Exception("Unable to convert to Name");
    return Name(first: first!, last: last!);
  }

  Map<String, dynamic> get toMap => {
        idKey: id,
        firstKey: first,
        lastKey: last,
      };
}
