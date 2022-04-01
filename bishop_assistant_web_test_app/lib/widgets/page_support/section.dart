import 'package:the_assistant/widgets/widgets.dart';
import 'package:sticky_headers/sticky_headers.dart';

///
/// Section.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/13/21
/// Copyright 2021 porter. All rights reserved.
///

class Section extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final MainAxisAlignment alignment;
  final Color titleBackgroundColor;

  const Section({
    required this.title,
    required this.children,
    this.alignment = MainAxisAlignment.center,
    this.titleBackgroundColor = lightGrey,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StickyHeader(
        header: Container(color: titleBackgroundColor, child: RowTitle(title)),
        content: Column(mainAxisAlignment: alignment, children: children));
  }
}
