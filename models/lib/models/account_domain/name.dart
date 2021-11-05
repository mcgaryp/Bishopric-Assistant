import 'package:models/shared/foundation.dart';

///
/// name.dart
/// bishopric-assistant
///
/// Created by Po on 9/28/21
/// Copyright 2021 Po. All rights reserved.
///

/// [Name] contains the names by which objects are known
class Name extends ValueObject<Name> {
  /// [_first] the first name of an object. Not mutable.
  late final String _first;

  /// [_last] the last name of an object. Not mutable.
  late final String _last;

  /// [Name(first: first, last: last)] constructor to ensure the proper
  ///   initialization of [_first] and [_last]
  Name({required String first, required String last})
      : super.decode({"first": first, "last": last, "name": "$first $last"}) {
    this.__first = first;
    this.__last = last;
  }

  /// [__last] private setter to ensure that [_last] is not empty and capitalized
  set __last(String name) => _last = name.capitalize;

  /// [__first] private setter to ensure that [_first] is not empty and capitalized
  set __first(String name) => _first = name.capitalize;

  /// [name] public getter that combines [first] and [last]
  String get name => "$first $last";

  /// [first] public getter of [_first]
  String get first => _first;

  /// [last] public getter of [_last]
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

  @override
  String toString() {
    return name;
  }
}
