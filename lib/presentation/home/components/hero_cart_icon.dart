import 'package:cash_n_carry/utils/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeroCartIcon extends StatelessWidget {
  const HeroCartIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Hero(
      tag: "hero_cart_icon",
      child: Icon(
        CupertinoIcons.cart,
        size: 30.0,
        color: AppColors.pinkColor,
      ),
    );
  }
}
