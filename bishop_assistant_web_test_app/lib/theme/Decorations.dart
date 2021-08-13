import 'package:bishop_assistant_web_test_app/theme/Colors.dart';
import 'package:flutter/cupertino.dart';

///
/// Decorations.dart
/// bishop_assistant_web_test_app
///
/// Created by Porter McGary on 8/13/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

const BoxDecoration boxDecoration = BoxDecoration(
    borderRadius: borderRadius20, color: white, boxShadow: boxShadow);

const BoxDecoration primaryButtonDecoration = BoxDecoration(
    borderRadius: borderRadius20, color: lightAccent, boxShadow: boxShadow);

const BoxDecoration textButtonDecoration = BoxDecoration();

const double padding8 = 8.0;
const double padding16 = 16.0;
const double padding32 = 32.0;

const double radius20 = 20.0;
const BorderRadius borderRadius20 = BorderRadius.all(Radius.circular(radius20));

const List<BoxShadow> boxShadow = [
  BoxShadow(offset: Offset(2, 4), blurRadius: 4, spreadRadius: 3, color: shadow)
];
