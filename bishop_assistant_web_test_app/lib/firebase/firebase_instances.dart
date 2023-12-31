import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:the_assistant/firebase/firebase_options.dart';
import 'package:the_assistant/main.dart';

///
/// firebase_instances.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 3/3/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class FirebaseInstances {
  static bool _isInitialized = false;

  // Init that will only initialize the firebase once and only once
  static Future<void> init() async {
    try {
      List<FirebaseApp> apps = Firebase.apps;
      if (kDebugMode) print("Current FirebaseApps: $apps");
      _isInitialized = true;
      return;
    } catch (e) {
      // not Initialized
      try {
        final dev = DevFirebaseOptions();
        FirebaseOptions options = await dev.currentPlatform;
        if (kDebugMode)
          print("Attempting to initialize FirebaseApp: \'${dev.name}\'");
        await Firebase.initializeApp(options: options);
        if (kDebugMode) print("Initialized FirebaseApp: \'${dev.name}\'");

        if (isBeta && !kDebugMode) {
          final beta = BetaFirebaseOptions();
          options = await beta.currentPlatform;
          if (kDebugMode)
            print("Attempting to initialize FirebaseApp: \'${beta.name}\'");
          await Firebase.initializeApp(options: options, name: beta.name);
          if (kDebugMode) print("Initialized FirebaseApp: \'${beta.name}\'");
        }

        if (isProd && !kDebugMode) {
          final prod = ProdFirebaseOptions();
          options = await prod.currentPlatform;
          if (kDebugMode)
            print("Attempting to initialize FirebaseApp: \'${prod.name}\'");
          await Firebase.initializeApp(options: options, name: prod.name);
          if (kDebugMode) print("Initialized FirebaseApp: \'${prod.name}\'");
        }

        _isInitialized = true;
      } catch (e) {
        if (kDebugMode) print(e);
        throw e;
      }
    }
  }

  static bool get isInitialized => _isInitialized;

  // Get the Firebase App
  static FirebaseApp get app {
    FirebaseApp app;
    if (isBeta && !kDebugMode) {
      app = Firebase.app(BetaFirebaseOptions().name);
    } else if (isProd && !kDebugMode) {
      app = Firebase.app(ProdFirebaseOptions().name);
    } else {
      app = Firebase.app();
    }

    return app;
  }

  // Get the Firebase Authentication Instance
  static FirebaseAuth get auth {
    if (kDebugMode) print("Requesting FirebaseAuth with \'${app.name}\'");
    return FirebaseAuth.instanceFor(app: app);
  }

  // Get the Firebase Firestore Instance
  static FirebaseFirestore get firestore {
    if (kDebugMode) print("Requesting FirebaseFirestore with \'${app.name}\'");
    return FirebaseFirestore.instanceFor(app: app);
  }

  // Get the Firebase Storage Instance
  static FirebaseStorage get storage {
    if (kDebugMode) print("Requesting FirebaseStorage with \'${app.name}\'");
    return FirebaseStorage.instanceFor(app: app);
  }
}
