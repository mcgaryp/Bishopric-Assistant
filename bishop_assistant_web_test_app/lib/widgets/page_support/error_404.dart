import 'package:the_assistant/theme/theme.dart';
import 'package:the_assistant/util/util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

///
/// error_404.dart
/// bishop_assistant_web_test_app
///
/// Created by Po on 8/17/21
/// Copyright 2021 Po. All rights reserved.
///

class Error404 extends StatelessWidget {
  final Object? msg;

  const Error404({Key? key, this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String text = sPage404;
    if (msg != null) text = "Error: $msg";
    if (kDebugMode) print(text);
    return Text(text, style: bodyRed);
  }
}
