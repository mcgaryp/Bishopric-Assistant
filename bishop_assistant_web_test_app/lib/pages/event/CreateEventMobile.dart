import 'package:bishop_assistant_web_test_app/util/Strings.dart';
import 'package:bishop_assistant_web_test_app/widgets/Section.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/CreateEvent.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/MobileConentSnapShot.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/light_page/LightPage.dart';
import 'package:flutter/material.dart';

///
/// CreateEventMobile.dart
/// bishop_assistant_web_test_app
///
/// Created by Po on 8/15/21
/// Copyright 2021 Po. All rights reserved.
///

class CreateEventMobile extends StatelessWidget {
  const CreateEventMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LightPage.mobile(MobileContentSnapShot([
      Section(createEvent, [CreateEvent()])
    ]));
  }
}