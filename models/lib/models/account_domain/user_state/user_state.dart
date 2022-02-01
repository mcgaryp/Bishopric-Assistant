///
/// user_state.dart
/// bishopric-assistant
///
/// Created by Po on 1/30/22
/// Copyright 2022 Po. All rights reserved.
///

enum UserState {
  loadingIn,
  unauthenticated,
  authenticated,
  noOrganization,
  inOrganization,
}

extension UserStateExtension on UserState {
  operator <(UserState rhs) {
    return this.index < rhs.index;
  }

  operator <=(UserState rhs) {
    return this.index <= rhs.index;
  }

  operator >(UserState rhs) {
    return this.index > rhs.index;
  }

  operator >=(UserState rhs) {
    return this.index >= rhs.index;
  }
}
