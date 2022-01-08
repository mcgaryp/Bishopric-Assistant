import 'package:bishop_assistant_web_test_app/firebase_options.dart';
import 'package:bishop_assistant_web_test_app/state/state_container.dart';
import 'package:bishop_assistant_web_test_app/theme/theme_data.dart';
import 'package:bishop_assistant_web_test_app/util/util.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/error_404_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

///
/// main.dart
/// bishop_assistant_web_test_app
///
/// Created by Porter McGary on 8/13/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    FirebaseOptions options = await DevFirebaseOptions.currentPlatform;
    await Firebase.initializeApp(options: options);
    runApp(StateContainer(child: App()));
  } catch (e) {
    runApp(MaterialApp(home: Error404Page(msg: e.toString(), canLogin: false)));
  }
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: sTitle,
      theme: theme,
      routes: routes,
    );
  }
}
