import 'package:flutter/foundation.dart';
import 'package:models/shared/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

///
/// shared_preferences_helper.dart
///
///
/// Created by Porter McGary on 11/4/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

/// [SharedPreferencesHelper] is a class designed to make accessing the shared
/// preferences on a machine simple and quick. Preferences are items that should
/// be used when needing to quickly cache information about the user.
class SharedPreferencesHelper {
  /// The instance of the preferences
  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();

  /// [insert] inserts a value at a location of key in the preferences returning
  /// a boolean of success or failure
  Future<bool> insertString(String key, String value) async {
    SharedPreferences preferences = await _prefs;
    return await preferences.setString(key, value);
  }

  /// [find]s a String value from location [key] if no value is found null is
  /// returned
  Future<String?> findString(String key) async {
    SharedPreferences preferences = await _prefs;
    return preferences.getString(key);
  }

  /// [removeString] a value from the location [key] returns a successful true
  /// or failure false
  Future<bool> removeString(String key) async {
    SharedPreferences preferences = await _prefs;
    return preferences.remove(key);
  }

  /// [findMap] locates and returns information stored as a string in json form
  Future<Map<String, dynamic>> findMap(String key) async {
    SharedPreferences preferences = await _prefs;
    String? string = preferences.getString(key);
    if (string == null)
      throw EmptyStringError(forObject: "SharedPreferences with key: $key");
    Map<String, dynamic> map = Map();
    if (kDebugMode) print(string);
    String stripped =
        string.replaceAll("{", "").replaceAll("}", "").replaceAll(" ", "");
    List<String> lst = stripped.split(",");
    if (kDebugMode) print(lst);
    lst.forEach((element) {
      List<String> values = element.split(":");
      map[values.first] = values.last;
    });
    return map;
  }
}
