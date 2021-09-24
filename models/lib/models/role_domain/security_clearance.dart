///
/// security_clearance.dart
/// bishopric-assistant
///
/// Created by Po on 9/24/21
/// Copyright 2021 Po. All rights reserved.
///

enum SecurityClearance { creator, level1, level2, level3, level4, level5 }

extension Security on SecurityClearance {
  operator <(SecurityClearance rhs) {
    return this.index < rhs.index;
  }

  operator <=(SecurityClearance rhs) {
    return this.index <= rhs.index;
  }

  operator >(SecurityClearance rhs) {
    return this.index > rhs.index;
  }

  operator >=(SecurityClearance rhs) {
    return this.index >= rhs.index;
  }

  operator +(SecurityClearance rhs) {
    return this.index + 1;
  }

  operator -(SecurityClearance rhs) {
    return this.index - 1;
  }
}
