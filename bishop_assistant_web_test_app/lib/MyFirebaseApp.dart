import 'package:bishop_assistant_web_test_app/pages/event/EventPage.dart';
import 'package:bishop_assistant_web_test_app/theme/Colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

///
/// MyFirebaseApp.dart
/// bishop_assistant_web_test_app
///
/// Created by Porter McGary on 8/13/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class MyFirebaseApp extends StatelessWidget {
  const MyFirebaseApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkPrimary,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          // Initialize FlutterFire:
          future: Firebase.initializeApp(),
          builder: (BuildContext context, AsyncSnapshot<FirebaseApp> snapshot) {
            // Check for errors
            if (snapshot.hasError) {
              return SomethingWentWrong();
            }

            // Once complete, show your application
            if (snapshot.connectionState == ConnectionState.done) {
              // TODO: Consider using the Home page as the starting point and
              //    sending the user to login if there is not a current session
              //    open to load their personal information
              // return Login(
              return EventPage();
            }

            // Otherwise, show something whilst waiting for initialization to complete
            return Loading();
          },
        ),
      ),
    );
  }
}

class SomethingWentWrong extends StatelessWidget {
  const SomethingWentWrong({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: Center(child: Text("SOME wrong THING!!")));
  }
}

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: Center(child: Text("LOADING...")));
  }
}
