///
/// string_extentions.dart
/// bishopric-assistant
///
/// Created by Po on 9/22/21
/// Copyright 2021 Po. All rights reserved.
///

extension MyString on String {
  String get capitalize {
    return this.substring(0, 1).toUpperCase() + this.substring(1);
  }

  bool get isCapitalized {
    return this[0].toUpperCase() == this[0];
  }

  bool get isNotCapitalized {
    return this[0].toUpperCase() != this[0];
  }
}
