import 'package:bishop_assistant_web_test_app/navigation/RouteStrings.dart';
import 'package:bishop_assistant_web_test_app/util/Strings.dart';
import 'package:bishop_assistant_web_test_app/widgets/footer/FooterButton.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/LightPageMobile.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/LightPageWeb.dart';
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
  final List<Widget> children;
  const LightPage({required this.children, Key? key}) : super(key: key);

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
          return LightPageMobile(children, footer);
        case DeviceScreenType.desktop:
        default:
          return LightPageWeb(children, footer);
      }
    });
  }
}
