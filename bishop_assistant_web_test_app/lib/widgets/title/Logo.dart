import 'package:flutter/material.dart';

///
/// Logo.dart
/// bishop_assistant_web_test_app
///
/// Created by Porter McGary on 8/13/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("Logo Here",
        style: TextStyle(color: Theme.of(context).accentColor));
  }
}
