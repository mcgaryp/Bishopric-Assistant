import 'package:the_assistant/widgets/widgets.dart';

///
/// $FILE_NAME.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 3/23/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class DeleteListTileBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: errorRed,
        child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: padding8),
              child: Icon(Icons.delete_forever_rounded, color: light),
            )));
  }
}
