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
    backgroundColor: darkPrimary,
    buttonColor: lightPrimary,
    primaryColor: darkPrimary,
    accentColor: light,
    errorColor: errorRed,
    cardColor: darkPrimary,
    highlightColor: lightPrimary,
    splashColor: darkPrimary,
    colorScheme: ColorScheme.light().copyWith(primary: darkPrimary));