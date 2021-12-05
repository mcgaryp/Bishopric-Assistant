import 'package:bishop_assistant_web_test_app/theme/Topography.dart';
import 'package:bishop_assistant_web_test_app/util/strings.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/Mobile.dart';
import 'package:flutter/material.dart';

///
/// error_404.dart
/// bishop_assistant_web_test_app
///
/// Created by Po on 8/17/21
/// Copyright 2021 Po. All rights reserved.
///

class Error404 extends Mobile {
  final String? msg;
  const Error404({Key? key, this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String text = page404;
    if (msg != null) text = "Error: $msg";
    return Text(text, style: bodyDark);
  }
}
