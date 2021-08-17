import 'package:bishop_assistant_web_test_app/theme/Colors.dart';
import 'package:flutter/material.dart';

///
/// ThemeData.dart
/// bishop_assistant_web_test_app
///
/// Created by Porter McGary on 8/13/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

final ThemeData theme = ThemeData(
  backgroundColor: darkAccent,
  buttonColor: lightAccent,
  primaryColor: darkAccent,
  accentColor: white,
  errorColor: error,
  cardColor: darkAccent,
  highlightColor: lightAccent,
  splashColor: darkAccent,
  colorScheme: ColorScheme.light().copyWith(
    primary: darkAccent
  )
);
