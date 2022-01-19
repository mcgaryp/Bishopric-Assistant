import 'dart:io';

import 'package:bishop_assistant_web_test_app/theme/theme.dart';
import 'package:bishop_assistant_web_test_app/util/util.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/app_bar/action_model.dart';
import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

///
/// my_scaffold.dart
/// bishopric-assistant
///
/// Created by Po on 12/29/21
/// Copyright 2021 Po. All rights reserved.
///

class MyScaffold {
  static List<Widget> _compactActions = [];
  static List<Widget> _actions = [];
  static late Widget _child;
  static late StateContainerState _container;

  static Scaffold currentScaffold(
      BuildContext context, List<ActionModel> models, Widget child) {
    _container = StateContainer.of(context);
    _compactActions = [MyDrawerHeader(_container.account)];
    _child = child;
    // Full screen width and height
    double width = MediaQuery.of(context).size.width;

    if (width < 700) {
      for (ActionModel model in models) {
        if (model.label != null) _compactActions.add(model.compactButton);
      }
      return _compact;
    } else
      _actions = models.map((e) => e.webButton).toList();
    return _large;
  }

  // Footer
  static final List<Widget> _footer = [
    FooterButton(label: sLegal, path: rLegal),
    FooterButton(label: sPrivacy, path: rPrivacy),
    FooterButton(label: sSiteMap, path: rHome),
    Text(_container.version, style: bodyDark),
    Text(_container.copyRight, style: bodyDark),
  ];

  static Scaffold get _compact => Scaffold(
        backgroundColor: lightGrey,
        drawer: SafeArea(
          child: Drawer(
              child: Column(
            children: [
              Expanded(child: ListView(children: _compactActions)),
              Wrap(direction: Axis.horizontal, alignment: WrapAlignment.center, runAlignment: WrapAlignment.center, spacing: 20.0, children: _footer),
            ],
          )),
        ),
        appBar: AppBar(
          backgroundColor: darkPrimary,
          title: MyTitle(),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
              top: padding8, left: padding8, right: padding8),
          child: Center(child: _child),
        ),
      );

  static Scaffold get _large => Scaffold(
        backgroundColor: lightGrey,
        appBar: AppBar(
          backgroundColor: darkPrimary,
          leading: Logo(),
          centerTitle: false,
          title: MyTitle(),
          actions: _actions,
        ),
        body: Padding(
          padding: const EdgeInsets.only(
              top: padding8, left: padding8, right: padding8),
          child: Center(child: _child),
        ),
        persistentFooterButtons: _footer,
      );
}
