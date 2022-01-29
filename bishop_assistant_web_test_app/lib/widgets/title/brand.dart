import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';

///
/// Brand.dart
/// bishop_assistant_web_test_app
///
/// Created by Porter McGary on 8/13/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class Brand extends StatelessWidget {
  final bool isExpanded;

  const Brand({this.isExpanded = true, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoText(sBrand, style: largeTitle, isExpanded: isExpanded);
  }
}
