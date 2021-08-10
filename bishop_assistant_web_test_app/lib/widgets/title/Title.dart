import 'package:flutter/material.dart';

import 'Brand.dart';
import 'Logo.dart';

class MyTitle extends StatelessWidget {
  const MyTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Logo(), Expanded(child: Brand())],
      ),
    );
  }
}
