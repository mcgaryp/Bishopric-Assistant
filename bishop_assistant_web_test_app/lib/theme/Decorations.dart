import 'package:bishop_assistant_web_test_app/theme/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

const BoxDecoration contentSnapShotDecoration = BoxDecoration(
    borderRadius: borderRadiusTop20, color: darkAccent, boxShadow: boxShadow);

const BoxDecoration darkContentDecoration = BoxDecoration(color: darkAccent);

const BoxDecoration textButtonDecoration = BoxDecoration();

final BoxDecoration borderDecoration =
    BoxDecoration(border: Border.all(color: Colors.red));

const double padding4 = 4.0;
const double padding8 = 8.0;
const double padding16 = 16.0;
const double padding32 = 32.0;

const double radius20 = 20.0;
const BorderRadius borderRadius20 = BorderRadius.all(Radius.circular(radius20));
const BorderRadius borderRadiusTop20 =
    BorderRadius.vertical(top: Radius.circular(radius20));

const List<BoxShadow> boxShadow = [
  BoxShadow(offset: Offset(2, 4), blurRadius: 4, spreadRadius: 3, color: shadow)
];
