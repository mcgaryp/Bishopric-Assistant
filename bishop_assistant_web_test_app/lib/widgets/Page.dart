import 'package:bishop_assistant_web_test_app/theme/Decorations.dart';
import 'package:bishop_assistant_web_test_app/widgets/Content.dart';
import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  final List<Widget> children;

  const MyPage({required this.children, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Content(
        child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(padding8),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: children))),
      ),
    );
  }
}
