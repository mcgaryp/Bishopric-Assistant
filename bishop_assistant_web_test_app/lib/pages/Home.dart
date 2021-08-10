import 'package:bishop_assistant_web_test_app/widgets/Page.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyPage(children: [
      Container(
        child: Center(child: Text("HOME!")),
      ),
    ]);
  }
}
