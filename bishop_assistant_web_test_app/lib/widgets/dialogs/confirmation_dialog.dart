import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';

///
/// confirmation_dialog.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 1/28/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class ConfirmationDialog extends StatelessWidget {
  final void Function() onConfirm;
  final String title;
  final String content;

  const ConfirmationDialog({
    Key? key,
    required this.onConfirm,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      shape: roundedBorder,
      actions: [
        MyButton(
            label: sYes,
            onPressed: onConfirm,
            isExpanded: false,
            style: MyButtonStyle.errorText),
        MyButton(
            label: sNo,
            onPressed: () => Navigator.pop(context),
            isExpanded: false,
            style: MyButtonStyle.text),
      ],
    );
  }
}
