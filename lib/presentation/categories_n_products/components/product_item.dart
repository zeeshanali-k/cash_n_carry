import 'package:cash_n_carry/domain/models/product.dart';
import 'package:cash_n_carry/presentation/categories_n_products/components/hero_network_image.dart';
import 'package:cash_n_carry/presentation/categories_n_products/components/hero_title.dart';
import 'package:cash_n_carry/utils/constants/app_constants.dart';
import 'package:cash_n_carry/utils/theme/app_colors.dart';
import 'package:cash_n_carry/utils/theme/text_styles.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatefulWidget {
  final Product product;
  final String categoryIcon;
  final Function(Product) onItemClicked;

  const ProductItem(
      {Key? key,
      required this.categoryIcon,
      required this.product,
      required this.onItemClicked})
      : super(key: key);

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  final imgWidthHeight = 80;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Column(
          children: [
            SizedBox(
              height: imgWidthHeight / 2,
            ),
            SizedBox(
              width: imgWidthHeight *2,
              child: Card(
                elevation: 3.0,
                shadowColor: AppColors.pinkColor.withAlpha(120),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                child: InkWell(
                  onTap: () {
                    widget.onItemClicked(widget.product);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: imgWidthHeight / 2,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.product.name,
                          style: TextStyles.textLargeBlackBold,
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                            widget.product.inStock
                                ? "In Stock"
                                : "Out of stock",
                            style: TextStyles.textSmallGreyNormal),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        HeroNetworkImage(
          imgHeight: imgWidthHeight,
          imgWidth: imgWidthHeight,
          product: widget.product,
          categoryIcon: widget.categoryIcon,
        ),
      ],
    );
  }
}
