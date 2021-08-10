import 'package:flutter/material.dart';

class Content extends StatelessWidget {
  final Widget child;
  const Content({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            constraints: BoxConstraints(maxWidth: 1200), child: child));
  }
}
