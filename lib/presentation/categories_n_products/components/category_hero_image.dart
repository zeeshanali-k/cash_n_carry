import 'package:cash_n_carry/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';

class CategoryHeroImage extends StatelessWidget {
  final int imgWidthHeight;
  final String categoryIcon;

  const CategoryHeroImage(
      {required this.imgWidthHeight, Key? key, required this.categoryIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: imgWidthHeight.toDouble(),
      height: imgWidthHeight.toDouble(),
      child: Hero(
        tag: AppConstants.heroCategoryIcon+categoryIcon,
        child: Image.asset(
          categoryIcon,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
