import 'package:the_assistant/firebase/firebase_options/firebase_options.dart';

///
/// dev_firebase_options.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 2/28/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class DevFirebaseOptions extends FirebaseOption {
  DevFirebaseOptions() : super(envFileName: 'dev.env');
}
