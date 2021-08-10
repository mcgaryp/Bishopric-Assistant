import 'package:auto_size_text/auto_size_text.dart';
import 'package:bishop_assistant_web_test_app/theme/Fonts.dart';
import 'package:bishop_assistant_web_test_app/util/Strings.dart';
import 'package:flutter/material.dart';

class Brand extends StatelessWidget {
  const Brand({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      brand,
      style: brandStyle,
      maxLines: 1,
    );
  }
}
