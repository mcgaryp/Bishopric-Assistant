import 'package:the_assistant/firebase/firebase_instances.dart';
import 'package:the_assistant/pages/signup_login/login_page.dart';
import 'package:the_assistant/pages/signup_login/signup_beta_page.dart';
import 'package:the_assistant/widgets/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

///
/// main.dart
/// bishop_assistant_web_test_app
///
/// Created by Porter McGary on 8/13/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

/// Flutter Design Patterns
///   https://mkobuolys.medium.com/flutter-design-patterns-0-introduction-5e88cfff6792

/// Managing hosting
///   https://firebase.google.com/docs/hosting/manage-hosting-resources#preview-channel-expiration

/// Firebase Flavoring with Android & iOS
///   https://medium.com/@animeshjain/build-flavors-in-flutter-android-and-ios-with-different-firebase-projects-per-flavor-27c5c5dac10b
///   https://github.com/animeshjain/flavor_test
/// Firebase Flavoring help checkout for Web
///   https://stackoverflow.com/questions/66560305/flutter-firebase-setting-different-deployment-targets-for-ios-android-and-w

// Environment variables for flavoring
const bool isBeta = bool.fromEnvironment('beta');
const bool isProd = bool.fromEnvironment('prod');
const bool isDebug = bool.fromEnvironment('dev');

void main() {
  runApp(StateContainer(child: App()));
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    // Hide bottom navigation on android and top status bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    return MaterialApp(
      title: sAppName,
      theme: theme,
      routes: routes,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (context) {
          final regExpPattern = RegExp(r'^/signup-beta/?');
          if (regExpPattern.hasMatch(settings.name ?? "")) {
            return SignupBetaPage();
          }

          if (FirebaseInstances.isInitialized) return LoginPage();

          return FutureBuilder<FirebaseApp>(
              future: _initFirebase(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return LoginPage();
                }

                if (snapshot.hasError)
                  Error404Page(msg: snapshot.error.toString(), canLogin: false);

                return DarkPage(
                  showSpinner: true,
                );
              });
        });
      },
    );
  }

  Future<FirebaseApp> _initFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    try {
      await FirebaseInstances.init();
      return FirebaseInstances.app;
    } catch (e) {
      if (kDebugMode) print(e);
      MyToast.toastError(e);
      throw e;
    }
  }
}
