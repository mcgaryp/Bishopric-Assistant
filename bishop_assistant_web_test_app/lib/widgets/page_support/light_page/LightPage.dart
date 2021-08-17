import 'package:bishop_assistant_web_test_app/navigation/RouteStrings.dart';
import 'package:bishop_assistant_web_test_app/util/Strings.dart';
import 'package:bishop_assistant_web_test_app/widgets/footer/FooterButton.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/Error404Page.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/Mobile.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/Web.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/light_page/LightPageMobile.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/light_page/LightPageWeb.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

///
/// LightPage.dart
/// bishop_assistant_web_test_app
///
/// Created by Porter McGary on 8/13/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class LightPage extends StatelessWidget {
  late final List<Web> children;
  late final Mobile child;
  late final bool _mobileButton;
  late final String path;

  LightPage.mobileAction(this.child, this.path, {Key? key}) : super(key: key) {
    _mobileButton = true;
    children = [];
  }

  LightPage.mobile(this.child, {Key? key}) : super(key: key) {
    _mobileButton = false;
    path = "";
  }

  LightPage.web(this.children, {Key? key}) : super(key: key);

  LightPage.both(this.child, {Key? key}) : super(key: key) {
    _mobileButton = false;
    path = "";
    children = [child];
  }

  @override
  Widget build(BuildContext context) {
    // Footer
    final List<Widget> footer = [
      FooterButton(label: legal, path: rLegal),
      FooterButton(label: privacy, path: rPrivacy),
      FooterButton(label: "SiteMap", path: rHome)
    ];

    return ResponsiveBuilder(builder: (context, size) {
      switch (size.deviceScreenType) {
        case DeviceScreenType.mobile:
        case DeviceScreenType.tablet:
          return LightPageMobile(child, footer,
              path: path, hasButton: _mobileButton);

        case DeviceScreenType.desktop:
          return LightPageWeb(children, footer);
        default:
          return Error404Page();
      }
    });
  }
}
