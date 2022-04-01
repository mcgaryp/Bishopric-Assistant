import 'package:the_assistant/firebase/firebase_options/environment.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

///
/// firebase_options.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 2/28/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

abstract class FirebaseOption {
  late Environment _env;
  final String envFileName;
  final String name;

  FirebaseOption({required this.envFileName, this.name = 'default'});

  Future<FirebaseOptions> get currentPlatform async {
    _env = await Environment.instance(envFileName);

    if (kIsWeb) {
      return _web;
    }
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return _android;
      case TargetPlatform.iOS:
        return _ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  FirebaseOptions get _web => FirebaseOptions(
        apiKey: _env.webApiKey,
        appId: _env.webAppID,
        messagingSenderId: _env.webMessagingSenderID,
        projectId: _env.webProjectID,
        authDomain: _env.webAuthDomain,
        storageBucket: _env.webStorageBucket,
        measurementId: _env.webMeasurementID,
      );

  FirebaseOptions get _android => FirebaseOptions(
        apiKey: _env.androidApiKey,
        appId: _env.androidAppID,
        messagingSenderId: _env.androidMessagingSenderID,
        projectId: _env.androidProjectID,
        storageBucket: _env.androidStorageBucket,
      );

  FirebaseOptions get _ios => FirebaseOptions(
        apiKey: _env.iosApiKey,
        appId: _env.iosAppID,
        messagingSenderId: _env.iosMessagingSenderID,
        projectId: _env.iosProjectID,
        storageBucket: _env.iosStorageBucket,
        iosClientId: _env.iosClientID,
        iosBundleId: _env.iosBundleID,
      );
}
