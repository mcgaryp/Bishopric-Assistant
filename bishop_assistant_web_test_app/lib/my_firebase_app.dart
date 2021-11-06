import 'package:bishop_assistant_web_test_app/pages/signup_login/login_page.dart';
import 'package:bishop_assistant_web_test_app/theme/Colors.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/error_404_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

///
/// my_firebase_app.dart
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
              return LoginPage();
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
