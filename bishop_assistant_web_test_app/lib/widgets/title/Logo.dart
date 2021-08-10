import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("Logo Here",
        style: TextStyle(color: Theme.of(context).accentColor));
  }
}
