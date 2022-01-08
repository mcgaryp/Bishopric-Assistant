import 'package:bishop_assistant_web_test_app/widgets/buttons/buttons.dart';
import 'package:flutter/cupertino.dart';

///
/// action_model.dart
/// bishopric-assistant
///
/// Created by Po on 12/29/21
/// Copyright 2021 Po. All rights reserved.
///

class ActionModel {
  String? label;
  String path;
  IconData? icon;
  int? notifications;

  ActionModel({this.label, required this.path, this.icon, this.notifications});

  WebNavigationButton get webButton {
    if (label != null)
      return WebNavigationButton.label(label,
          path: path, notifications: notifications);
    if (icon != null)
      return WebNavigationButton.icon(icon,
          path: path, notifications: notifications);
    throw ErrorDescription(
        "Label or Icon should not be null to access webButton");
  }

  MobileNavigationButton get compactButton {
    if (label != null)
      return MobileNavigationButton(label!,
          path: path, notifications: notifications);
    throw ErrorDescription(
        "Label or Icon should not be null to access compactButton");
  }
}
