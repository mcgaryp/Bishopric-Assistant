import 'package:flutter/material.dart';

class MySpacer extends StatelessWidget {
  const MySpacer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(constraints: BoxConstraints(minHeight: 50));
  }
}
