import 'package:bishop_assistant_web_test_app/navigation/RouteStrings.dart';
import 'package:bishop_assistant_web_test_app/util/Strings.dart';
import 'package:bishop_assistant_web_test_app/widgets/footer/FooterButton.dart';
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
  final List<Widget>? children;
  final Widget? child;
  const LightPage({this.children, this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Footer
    final List<Widget> footer = [
      FooterButton(label: legal, path: rLegal),
      FooterButton(label: privacy, path: rPrivacy),
      FooterButton(label: "SiteMap", path: rHome)
    ];

    return ResponsiveBuilder(builder: (context, size) {
      if (child == null && children == null)
        throw Exception("there needs to have either a child or children");

      switch (size.deviceScreenType) {
        case DeviceScreenType.mobile:
        case DeviceScreenType.tablet:
          return LightPageMobile(child!, footer);
        case DeviceScreenType.desktop:
        default:
          return LightPageWeb(children!, footer);
      }
    });
  }
}
