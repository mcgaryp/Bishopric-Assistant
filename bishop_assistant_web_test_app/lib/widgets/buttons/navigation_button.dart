import 'package:flutter/material.dart';

///
/// NavigationButton.dart
/// bishop_assistant_web_test_app
///
/// Created by Po on 8/18/21
/// Copyright 2021 Po. All rights reserved.
///

abstract class NavigationButton extends StatelessWidget {
  final String path;

  const NavigationButton(this.path, {Key? key}) : super(key: key);

  void navigate(BuildContext context) => Navigator.pushNamed(context, path);
}
