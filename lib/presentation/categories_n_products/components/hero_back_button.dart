import 'package:cash_n_carry/utils/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeroBackButton extends StatelessWidget {
  const HeroBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "hero_back_button",
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.greyBg,
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.all(10),
        child: const Icon(
          CupertinoIcons.back,
          color: AppColors.pinkColor,
        ),
      ),
    );
  }
}
