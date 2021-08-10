import 'package:bishop_assistant_web_test_app/pages/Login.dart';
import 'package:bishop_assistant_web_test_app/widgets/Content.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MyFirebaseApp extends StatelessWidget {
  const MyFirebaseApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
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
              return Content(child: Login());
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
