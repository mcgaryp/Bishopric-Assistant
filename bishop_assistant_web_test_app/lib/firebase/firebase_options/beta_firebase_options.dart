import 'package:bishop_assistant_web_test_app/firebase/firebase_options/firebase_options.dart';

///
/// beta_firebase_options.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 2/28/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class BetaFirebaseOptions extends FirebaseOption {
  BetaFirebaseOptions() : super(envFileName: 'beta.env', name: 'beta');
}
