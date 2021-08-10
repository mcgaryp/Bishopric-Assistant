import 'package:flutter/material.dart';

class MyConstrainedBox300 extends StatelessWidget {
  final List<Widget> children;
  const MyConstrainedBox300({required this.children, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 300),
      child: Column(children: children),
    );
  }
}

class MyConstrainedBox200 extends StatelessWidget {
  final List<Widget> children;
  const MyConstrainedBox200({required this.children, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 200),
      child: Column(children: children),
    );
  }
}
