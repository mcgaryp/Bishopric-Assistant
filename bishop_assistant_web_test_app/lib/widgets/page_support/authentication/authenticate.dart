import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

///
/// authenticate.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 12/1/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class Authenticate extends StatelessWidget {
  final Widget child;

  const Authenticate({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // The status of the user needs to be checked to ensure they have
    // authenticated access to the application.
    final isAuthenticated = StateContainer.of(context).isAuthenticated;
    if (isAuthenticated) return child;
    return Error404Page(msg: "Unauthenticated User");
  }
}
