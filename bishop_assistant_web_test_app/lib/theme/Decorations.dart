import 'package:bishop_assistant_web_test_app/theme/Colors.dart';
import 'package:flutter/cupertino.dart';

const BoxDecoration boxDecoration = BoxDecoration(
    borderRadius: borderRadius20, color: white, boxShadow: boxShadow);

const BoxDecoration buttonDecoration = BoxDecoration(
    borderRadius: borderRadius20, color: accent, boxShadow: boxShadow);

const double padding8 = 8.0;
const double padding16 = 16.0;
const double padding32 = 32.0;

const double radius20 = 20.0;
const BorderRadius borderRadius20 = BorderRadius.all(Radius.circular(radius20));

const List<BoxShadow> boxShadow = [
  BoxShadow(offset: Offset(2, 4), blurRadius: 4, spreadRadius: 3, color: shadow)
];
