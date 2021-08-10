// Import the firebase_core plugin
import 'package:bishop_assistant_web_test_app/MyFirebaseApp.dart';
import 'package:bishop_assistant_web_test_app/navigation/RouteStrings.dart';
import 'package:bishop_assistant_web_test_app/pages/Home.dart';
import 'package:bishop_assistant_web_test_app/pages/Login.dart';
import 'package:bishop_assistant_web_test_app/pages/Signup.dart';
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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Firestore Demo",
        theme: ThemeData(
            backgroundColor: Color.fromRGBO(11, 83, 112, 1),
            buttonColor: Color.fromRGBO(113, 146, 190, 1),
            primaryColor: Color.fromRGBO(11, 83, 112, 1),
            accentColor: Color.fromRGBO(251, 251, 255, 1),
            errorColor: Color.fromRGBO(231, 58, 35, 1)),
        routes: {
          "/": (context) => MyFirebaseApp(),
          rHome: (context) => Home(),
          rLogin: (context) => Login(),
          rSignup: (context) => Signup(),
        });
  }
}

/// CLASS updates AUTOMATICALLY when data is changed in the database
// class UserInformation extends StatefulWidget {
//   final Collections collectionPath;
//   UserInformation({required this.collectionPath});
//
//   @override
//   _UserInformationState createState() => _UserInformationState();
// }
//
// class _UserInformationState extends State<UserInformation> {
//   final Stream<QuerySnapshot> _usersStream =
//       FirestoreHelper.stream(Collections.roles);
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: _usersStream,
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         List<DocumentSnapshot> data = FirestoreHelper.listDocSnap(snapshot);
//
//         return ListView(
//           children: data.map((DocumentSnapshot document) {
//             Map<String, dynamic> data =
//                 document.data()! as Map<String, dynamic>;
//             return Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(data['name']),
//                   Text(data['security'].toString()),
//                 ]);
//           }).toList(),
//         );
//       },
//     );
//   }
// }
