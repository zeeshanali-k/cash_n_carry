import 'dart:developer';

import 'package:cash_n_carry/domain/models/product.dart';
import 'package:cash_n_carry/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';

class HeroNetworkImage extends StatelessWidget {
  final imgWidth;
  final imgHeight;
  final Product product;
  final categoryIcon;

  const HeroNetworkImage({
    Key? key,
    required this.imgHeight,
    required this.imgWidth,
    required this.product,
    required this.categoryIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: imgWidth.toDouble(),
      height: imgHeight.toDouble(),
      child: Hero(
        tag: AppConstants.heroProductIcon + product.name,
        child: Image(
          image: NetworkImage(product.image),
          fit: BoxFit.contain,
          loadingBuilder: (ctx, w, imageChunk) {
            if (imageChunk == null) {
              return w;
            } else {
              return Image.asset(
                categoryIcon,
                width: imgWidth.toDouble(),
                height: imgHeight.toDouble(),
              );
            }
          },
          errorBuilder: (ctx, _, error) {
            log(error.toString());
            return Image.asset("assets/images/logo.png");
          },
        ),
      ),
    );
  }
}
