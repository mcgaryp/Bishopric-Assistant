import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';

///
/// MyTitle.dart
/// bishop_assistant_web_test_app
///
/// Created by Porter McGary on 8/13/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class MyTitle extends StatelessWidget {
  const MyTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 500, child: Brand(isExpanded: false));
  }
}
