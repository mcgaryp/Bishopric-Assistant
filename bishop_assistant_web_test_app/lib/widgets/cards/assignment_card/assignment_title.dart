import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:models/models/assignment.dart';

///
/// assignment_title.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 2/4/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class AssignmentTitle extends StatelessWidget {
  final Assignment assignment;
  final void Function()? toggle;
  final bool _isLight;

  AssignmentTitle(this.assignment, {Key? key, this.toggle})
      : this._isLight = false,
        super(key: key);

  AssignmentTitle.light(this.assignment, {required this.toggle, Key? key})
      : this._isLight = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _isLight
              ? Flexible(child: CardTitle.light(assignment.title))
              : Flexible(child: CardTitle(assignment.title)),
          if (assignment.isNotArchived)
            MyButton(
                style: _isLight
                    ? MyButtonStyle.lightText
                    : MyButtonStyle.smallText,
                isExpanded: false,
                label: sEdit,
                onPressed: () {
                  if (toggle != null) toggle!();
                }),
        ],
      ),
      _isLight
          ? CardSubtitle.light(assignment.dueDate)
          : CardSubtitle(assignment.dueDate),
    ]);
  }
}
