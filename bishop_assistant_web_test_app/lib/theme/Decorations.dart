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

/// Floating Boxes
const BoxDecoration floatingLightBox = BoxDecoration(
    color: light, boxShadow: _boxShadow, borderRadius: _borderRadius20);

const BoxDecoration floatingLightPrimaryBox = BoxDecoration(
    color: lightPrimary, boxShadow: _boxShadow, borderRadius: _borderRadius20);

const BoxDecoration floatingDarkPrimaryHalfBorderBox = BoxDecoration(
    color: darkPrimary,
    boxShadow: _boxShadow,
    borderRadius: _borderRadiusTop20);

const BoxDecoration floatingErrorRedBox = BoxDecoration(
    color: errorRed, boxShadow: _boxShadow, borderRadius: _borderRadius20);

/// Flat Boxes
const BoxDecoration darkPrimaryBox = BoxDecoration(color: darkPrimary);

const BoxDecoration lightbox = BoxDecoration(color: light);

/// Bordered Boxes
const BoxDecoration darkBorderBox = BoxDecoration(
    color: light, borderRadius: _borderRadius20, border: _darkBorder);

const BoxDecoration errorRedBorderBox = BoxDecoration(
    color: light, border: _errorRedBorder, borderRadius: _borderRadius20);

/// ButtonStyles
final ButtonStyle textButtonStyle =
    ButtonStyle(overlayColor: MaterialStateProperty.all(Colors.transparent));

/// OutlineInputBorders
const OutlineInputBorder lightPrimaryInputBorder = OutlineInputBorder(
    borderSide: BorderSide(color: lightPrimary), borderRadius: _borderRadius20);

const OutlineInputBorder darkPrimaryInputBorder = OutlineInputBorder(
    borderSide: BorderSide(color: darkPrimary), borderRadius: _borderRadius20);

const OutlineInputBorder errorRedInputBorder = OutlineInputBorder(
    borderSide: BorderSide(color: errorRed), borderRadius: _borderRadius20);

/// Paddings
const double padding4 = 4.0;
const double padding8 = 8.0;
const double padding16 = 16.0;
const double padding32 = 32.0;

/// PRIVATE VARIABLES
const double _radius20 = 20.0;
const BorderRadius _borderRadius20 =
    BorderRadius.all(Radius.circular(_radius20));
const BorderRadius _borderRadiusTop20 =
    BorderRadius.vertical(top: Radius.circular(_radius20));

/// Border
const Border _darkBorder = Border(
    top: _darkBorderSide,
    bottom: _darkBorderSide,
    left: _darkBorderSide,
    right: _darkBorderSide);
const Border _errorRedBorder = Border(
    top: _errorRedBorderSide,
    bottom: _errorRedBorderSide,
    left: _errorRedBorderSide,
    right: _errorRedBorderSide);

/// Border Side
const BorderSide _darkBorderSide = BorderSide(color: dark);
const BorderSide _errorRedBorderSide = BorderSide(color: errorRed);

/// Shadow
const List<BoxShadow> _boxShadow = [
  BoxShadow(offset: Offset(2, 4), blurRadius: 4, spreadRadius: 3, color: shadow)
];
