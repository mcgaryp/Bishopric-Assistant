import 'package:bishop_assistant_web_test_app/pages/signup_login/Login.dart';
import 'package:bishop_assistant_web_test_app/theme/Colors.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/Error404Page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

///
/// MyFirebaseApp.dart
/// bishop_assistant_web_test_app
///
/// Created by Porter McGary on 8/13/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

/// [MyFirebaseApp] is the entry point for the application. Without this the
/// firebase will not function right and the application will result in an error
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
              return Error404Page();
            }

            // Once complete, show your application
            if (snapshot.connectionState == ConnectionState.done) {
              // TODO: Consider using the Home page as the starting point and sending the user to login if there is not a current session open to load their personal information
              return Login();
              // return EventPage();
            }

            // Otherwise, show something whilst waiting for initialization to complete
            return Loading();
          },
        ),
      ),
    );
  }
}

// TODO: Implement this as a page with a spinner
class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: Center(child: Text("LOADING...")));
  }
}
