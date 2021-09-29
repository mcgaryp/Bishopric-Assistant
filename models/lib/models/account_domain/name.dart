import 'package:models/shared/foundation.dart';

///
/// name.dart
/// bishopric-assistant
///
/// Created by Po on 9/28/21
/// Copyright 2021 Po. All rights reserved.
///

class Name extends ValueObject<Name> {
  late final String _first;
  late final String _last;

  Name({required String first, required String last})
      : super.decode({"first": first, "last": last, "name": "$first $last"}) {
    this.__first = first;
    this.__last = last;
  }

  set __last(String name) => _last = name.capitalize;

  set __first(String name) => _first = name.capitalize;

  String get name => "$first $last";

  String get first => _first;

  String get last => _last;

  @override
  bool sameValueAs(Name other) {
    return other.first == this.first && other.last == this.last;
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != Name) return false;
    return sameValueAs(other as Name);
  }

  @override
  Map<String, dynamic> toJson() =>
      {"first": first, "last": last, "name": "$first $last"};
}
