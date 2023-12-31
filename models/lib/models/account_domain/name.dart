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

  static const String firstKey = "first";
  static const String lastKey = "last";

  /// [Name(first: first, last: last)] constructor to ensure the proper
  ///   initialization of [_first] and [_last]
  Name({required String first, required String last}) {
    this.__first = first;
    this.__last = last;
  }

  Name.fromMap(Map<String, dynamic> map)
      : this(first: map[firstKey], last: map[lastKey]);

  /// [__last] private setter to ensure that [_last] is not empty and capitalized
  set __last(String name) {
    if (name.isEmpty) throw EmptyStringError(forObject: "Last Name");
    _last = name.capitalize;
  }

  /// [__first] private setter to ensure that [_first] is not empty and capitalized
  set __first(String name) {
    if (name.isEmpty) throw EmptyStringError(forObject: "First Name");
    _first = name.capitalize;
  }

  /// [fullName] public getter that combines [first] and [last]
  String get fullName => "$first $last";

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
  String toString() {
    return fullName;
  }

  @override
  Map<String, dynamic> get toMap => {firstKey: first, lastKey: last};
}
