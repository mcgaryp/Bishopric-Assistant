import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';

///
/// RowTitle.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/13/21
/// Copyright 2021 porter. All rights reserved.
///

class RowTitle extends StatelessWidget {
  final String label;

  const RowTitle(this.label, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Text(label, style: smallTitleDark)),
        MyDivider(color: darkText)
      ],
    );
  }
}
