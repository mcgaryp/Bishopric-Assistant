// Import the firebase_core plugin
import 'package:bishop_assistant_web_test_app/database/firestore.dart';
import 'package:bishop_assistant_web_test_app/util/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

/// We are using a StatefulWidget such that we only create the [Future] once,
/// no matter how many times our widget rebuild.
/// If we used a [StatelessWidget], in the event where [App] is rebuilt, that
/// would re-initialize FlutterFire and make our application re-enter loading state,
/// which is undesired.
class App extends StatefulWidget {
  // Create the initialization Future outside of `build`:
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      home: FutureBuilder(
        // Initialize FlutterFire:
        future: _initialization,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return SomethingWentWrong();
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            // return RoleNamesList();
            return UserInformation();
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return Loading();
        },
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

/// Returns a Text List of Role names
/// DOES NOT update automatically
class RoleNamesList extends StatelessWidget {
  final Collections collectionPath;
  const RoleNamesList(this.collectionPath, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference roles = FirestoreHelper.reference(collectionPath.value);

    return FutureBuilder<QuerySnapshot>(
      future: roles.get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          List<QueryDocumentSnapshot> data = snapshot.data!.docs;
          List<Widget> children = [];

          data.sort(FirestoreHelper.sortQueryById);

          for (QueryDocumentSnapshot d in data) {
            children.add(Text("${d["name"]}"));
          }

          return ListView(
            children: children,
          );
        }

        return Text("loading");
      },
    );
  }
}

/// CLASS updates AUTOMATICALLY when data is changed in the database
class UserInformation extends StatefulWidget {
  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  final Stream<QuerySnapshot> _usersStream =
      FirestoreHelper.stream(Collections.roles);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        List<DocumentSnapshot> data = FirestoreHelper.listDocSnap(snapshot);

        return ListView(
          children: data.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(data['name']),
                  Text(data['security'].toString()),
                ]);
          }).toList(),
        );
      },
    );
  }
}
