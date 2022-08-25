
import 'dart:developer';

import 'package:cash_n_carry/utils/theme/text_styles.dart';
import 'package:flutter/material.dart';

class HeroTitle extends StatelessWidget {
  final String title;
  String? tag;
  TextStyle? textStyle = TextStyles.textLargeBlackBold;
  HeroTitle({Key? key,required this.title,this.textStyle,this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    tag ??= title;
    log("Tag: $tag");
    return Hero(
      tag: title,
      child: Material(
        type: MaterialType.transparency,
        child: Text(
          title,
          style: textStyle,
          textAlign: TextAlign.start,
        ),
      ),
    );
  }
}
