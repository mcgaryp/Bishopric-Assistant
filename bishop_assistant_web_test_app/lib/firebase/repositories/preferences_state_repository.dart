import 'package:bishop_assistant_web_test_app/firebase/shared_preferences_helper.dart';
import 'package:models/models/account.dart';

///
/// preferences_state_repository.dart
/// bishopric-assistant
///
/// Created by Po on 1/30/22
/// Copyright 2022 Po. All rights reserved.
///

class PreferencesStateRepository extends SharedPreferencesHelper
    implements StateRepository {
  static const String _key = "User State";

  @override
  Future<UserState> find() async {
    String? str = await findString(_key);
    str ?? (throw Exception("Failed to find "));
    for (UserState state in UserState.values) {
      if (state.name == str) return state;
    }
    return UserState.unauthenticated;
  }

  @override
  Future<bool> insert(UserState state) {
    return insertString(_key, state.name);
  }

  @override
  Future<bool> remove() {
    return removeString(_key);
  }

  @override
  Future<bool> update(UserState state) {
    return insertString(_key, state.name);
  }
}
