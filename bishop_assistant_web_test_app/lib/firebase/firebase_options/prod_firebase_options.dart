import 'package:the_assistant/firebase/firebase_options/firebase_options.dart';

///
/// prod_firebase_options.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 2/28/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class ProdFirebaseOptions extends FirebaseOption {
  ProdFirebaseOptions() : super(envFileName: 'prod.env', name: 'prod');
}
