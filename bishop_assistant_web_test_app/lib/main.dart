import 'package:bishop_assistant_web_test_app/firebase_options.dart';
import 'package:bishop_assistant_web_test_app/pages/signup_login/login_page.dart';
import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:firebase_core/firebase_core.dart';

///
/// main.dart
/// bishop_assistant_web_test_app
///
/// Created by Porter McGary on 8/13/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

void main() async {
  runApp(StateContainer(child: App()));
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
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (context) {
          return FutureBuilder(
              future: _initFirebase(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done)
                  return LoginPage();

                if (snapshot.hasError)
                  Error404Page(msg: snapshot.error.toString(), canLogin: false);

                return DarkPage(
                    inputs: [], buttons: [SpinKitCircle(color: Colors.white)]);
              });
        });
      },
    );
  }

  _initFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    FirebaseOptions options = await DevFirebaseOptions.currentPlatform;
    await Firebase.initializeApp(options: options);
  }
}
