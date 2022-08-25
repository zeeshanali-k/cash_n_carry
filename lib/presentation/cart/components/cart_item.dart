import 'package:cash_n_carry/domain/models/product.dart';
import 'package:cash_n_carry/presentation/categories_n_products/components/hero_network_image.dart';
import 'package:cash_n_carry/presentation/categories_n_products/components/product_quantity_selector.dart';
import 'package:cash_n_carry/utils/theme/app_colors.dart';
import 'package:cash_n_carry/utils/theme/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartItem extends StatefulWidget {
  final Product product;
  final String categoryIcon;
  final VoidCallback onDeleteClicked;
  final Function(int) onQuantitySelected;

  const CartItem({
    Key? key,
    required this.onDeleteClicked,
    required this.product,
    required this.categoryIcon,
    required this.onQuantitySelected
  }) : super(key: key);

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  final imgWidthHeight = 90;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            children: [
              SizedBox(
                height: imgWidthHeight / 2,
              ),
              SizedBox(
                width: size.width,
                child: Card(
                  elevation: 3.0,
                  shadowColor: AppColors.pinkColor.withAlpha(120),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: imgWidthHeight / 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            widget.product.name,
                            style: TextStyles.textLargeBlackBold,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            "${widget.product.price} \$",
                            style: TextStyles.textSmallGreyBold,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(top: imgWidthHeight / 2, right: 10),
              child: SizedBox(
                width: size.width * 0.5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ProductQuantitySelector(
                        onQuantitySelected: (q) {
                          widget.onQuantitySelected(q);
                        },
                        defaultQuantity: widget.product.quantity,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: InkResponse(
                            onTap: widget.onDeleteClicked,
                            child: const Icon(
                              CupertinoIcons.delete,
                              size: 25,
                              color: AppColors.red,
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: HeroNetworkImage(
              imgHeight: imgWidthHeight,
              imgWidth: imgWidthHeight,
              product: widget.product,
              categoryIcon: widget.categoryIcon,
            ),
          ),
        ],
      ),
    );
  }
}
