import 'package:models/shared/exceptions.dart';

///
/// string_extensions.dart
/// bishopric-assistant
///
/// Created by Po on 9/22/21
/// Copyright 2021 Po. All rights reserved.
///

/// extension on [String] that includes methods that get specific properties
extension MyString on String {
  /// [capitalize] handles the capitalization of a string
  ///
  /// Checks that the string is not null
  /// Checks that the string is capitalized
  /// Returns a capitalized String
  String get capitalize {
    if (this.isEmpty) throw EmptyString();
    if (this.isNotCapitalized)
      return this.substring(0, 1).toUpperCase() + this.substring(1);
    return this;
  }

  /// [isCapitalized] returns a true if the string is capitalized
  bool get isCapitalized {
    if (this.isEmpty) throw EmptyString();
    return this[0].toUpperCase() == this[0];
  }

  /// [isNotCapitalized] returns a true if the string is NOT capitalized
  bool get isNotCapitalized {
    if (this.isEmpty) throw EmptyString();
    return this[0].toUpperCase() != this[0];
  }

  @Deprecated("Use `capitalize`")
  String get checkCapitalization {
    if (this.isEmpty) throw EmptyString();
    if (this.isNotCapitalized) return this.capitalize;
    return this;
  }
}
