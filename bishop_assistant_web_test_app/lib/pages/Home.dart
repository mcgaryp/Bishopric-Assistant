import 'package:bishop_assistant_web_test_app/widgets/LightPage.dart';
import 'package:flutter/material.dart';

///
/// Home.dart
/// bishop_assistant_web_test_app
///
/// Created by Porter McGary on 8/13/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LightPage(children: [
      Container(
        child: Center(child: Text("HOME!")),
      ),
    ]);
  }
}
