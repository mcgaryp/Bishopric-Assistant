import 'package:flutter/material.dart';

///
/// MySpacer.dart
/// bishop_assistant_web_test_app
///
/// Created by Porter McGary on 8/13/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class MySpacer extends StatelessWidget {
  const MySpacer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(constraints: BoxConstraints(minHeight: 50));
  }
}
