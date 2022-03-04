import 'package:flutter_dotenv/flutter_dotenv.dart';

///
/// environment.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 2/28/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class Environment {
  // Singleton pattern
  static final Environment _env = new Environment._internal();

  Environment._internal();

  static Future<Environment> instance(String envFileName) async {
    await dotenv.load(fileName: envFileName);
    return _env;
  }

  String get webApiKey => _EnvKey.WEB_API_KEY.getKey;

  String get webAppID => _EnvKey.WEB_APP_ID.getKey;

  String get webMessagingSenderID => _EnvKey.WEB_MESSAGING_SENDER_ID.getKey;

  String get webProjectID => _EnvKey.WEB_PROJECT_ID.getKey;

  String get webAuthDomain => _EnvKey.WEB_AUTH_DOMAIN.getKey;

  String get webStorageBucket => _EnvKey.WEB_STORAGE_BUCKET.getKey;

  String get webMeasurementID => _EnvKey.WEB_MEASUREMENT_ID.getKey;

  String get androidApiKey => _EnvKey.ANDROID_API_KEY.getKey;

  String get androidAppID => _EnvKey.ANDROID_APP_ID.getKey;

  String get androidMessagingSenderID =>
      _EnvKey.ANDROID_MESSAGING_SENDER_ID.getKey;

  String get androidProjectID => _EnvKey.ANDROID_PROJECT_ID.getKey;

  String get androidStorageBucket => _EnvKey.ANDROID_STORAGE_BUCKET.getKey;

  String get iosApiKey => _EnvKey.IOS_API_KEY.getKey;

  String get iosAppID => _EnvKey.IOS_APP_ID.getKey;

  String get iosMessagingSenderID => _EnvKey.IOS_MESSAGING_SENDER_ID.getKey;

  String get iosProjectID => _EnvKey.IOS_PROJECT_ID.getKey;

  String get iosBundleID => _EnvKey.IOS_BUNDLE_ID.getKey;

  String get iosStorageBucket => _EnvKey.IOS_STORAGE_BUCKET.getKey;

  String get iosClientID => _EnvKey.IOS_CLIENT_ID.getKey;
}

enum _EnvKey {
  WEB_API_KEY,
  WEB_APP_ID,
  WEB_MESSAGING_SENDER_ID,
  WEB_PROJECT_ID,
  WEB_AUTH_DOMAIN,
  WEB_STORAGE_BUCKET,
  WEB_MEASUREMENT_ID,
  ANDROID_API_KEY,
  ANDROID_APP_ID,
  ANDROID_MESSAGING_SENDER_ID,
  ANDROID_PROJECT_ID,
  ANDROID_STORAGE_BUCKET,
  IOS_API_KEY,
  IOS_APP_ID,
  IOS_MESSAGING_SENDER_ID,
  IOS_PROJECT_ID,
  IOS_STORAGE_BUCKET,
  IOS_CLIENT_ID,
  IOS_BUNDLE_ID,
}

extension _EnvKeyExtension on _EnvKey {
  String get getKey {
    String? str = dotenv.env[this.name];
    if (str != null) return str;
    throw Exception("ENV KEY: ${this.name} is not found");
  }
}
