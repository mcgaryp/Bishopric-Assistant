import 'package:models/models/account.dart';

///
/// mock_state_repository.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 2/14/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class MockStateRepository implements StateRepository {
  bool findFlag = false;
  bool insertFlag = false;
  bool removeFlag = false;
  bool updateFlag = false;

  final UserState userState;
  final bool shouldSucceed;

  MockStateRepository(
      {this.userState = UserState.loadingIn, this.shouldSucceed = true});

  @override
  Future<UserState> find() {
    findFlag = true;
    return Future.value(userState);
  }

  @override
  Future<bool> insert(UserState state) {
    insertFlag = true;
    return Future.value(shouldSucceed);
  }

  @override
  Future<bool> remove() {
    removeFlag = true;
    return Future.value(shouldSucceed);
  }

  @override
  Future<bool> update(UserState state) {
    updateFlag = true;
    return Future.value(shouldSucceed);
  }
}
